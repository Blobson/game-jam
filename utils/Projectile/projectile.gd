class_name Projectile extends Path2D

## Величина наносимого урона
@export var attack_power: int = 10

## Радиус поражения
@export var damage_radius: float = 0

## Скорость движения снаряда
@export var move_speed: float = 200.0

## Группа врагов, которым наносится урон
@export var damage_groups: Array[String] = ['enemies']

## Сцена взрыва снаряда
@export var explosion_scene: PackedScene

# Логика расчетов баллистической траектории
var ballistics: Ballistics


func _ready():
	if ballistics:
		var tween = $PathFollow2D.create_tween()
		tween.tween_method(_progress_ratio_animation, 0.0, 1.0, ballistics.time) \
			.set_trans(Tween.TRANS_LINEAR)
		tween.finished.connect(_on_impact.bind(null))
	$PathFollow2D/FlyingSFX.pitch_scale = randf_range(0.8, 1.2)
	$PathFollow2D/FlyingSFX.play()
	$PathFollow2D/ImpactDetector.body_entered.connect(_on_impact)


# Синусоидальная функция для анимации полёта снаряда 
# с замедлением в верхней точке полёта
func _progress_ratio_animation(value: float):
	# TODO: Оптимизировать функцию интерполяции с учётом верхней точки траектории
#	var ease_fn = (1.0 - cos(PI * value)) / 2.0
#	var delta = ease_fn - value
#	$PathFollow2D.progress_ratio = value - delta * 0.7
	$PathFollow2D.progress_ratio = value


## Рассчет времени полета до цели
func time_to_target(from: Vector2, to: Vector2) -> float:
	return Ballistics.new(from, to, move_speed).time


## Выстрел снарядом в указанную точку
func fire(from: Vector2, to: Vector2):
	# Расчет баллистической траектории
	ballistics = Ballistics.new(from, to, move_speed)

	# Построение траектории полёта
	curve = ballistics.create_trajectory()


## Обработка удара
func _on_impact(body: Node2D):
	if damage_radius > 0:
		apply_area_damage()
	elif is_suitable_target(body):
		apply_unit_damage(body)
	if explosion_scene:
		var explosion = explosion_scene.instantiate()
		explosion.position = $PathFollow2D.position
		NodeUtils.replace_node(self, explosion)
	else:
		queue_free()


## Наносим дамаг всем в зоне поражения
func apply_area_damage():
	for group in damage_groups:
		for target in get_tree().get_nodes_in_group(group):
			var d = target.global_position.distance_to($PathFollow2D.global_position)
			if d <= damage_radius:
				apply_unit_damage(target)


## Наносим дамаг одному юниту
func apply_unit_damage(body: Node2D):
	body.take_damage(attack_power)
	# TODO: некоторые снаряды, например стрела или огонь должны вешать эффекты на свои цели


func is_suitable_target(body: Node2D):
	if not body or not body.has_method("take_damage"):
		return false
	if body.has_method("is_dead") and body.is_dead():
		return false
	for group in damage_groups:
		if body.is_in_group(group):
			return true
	return false
