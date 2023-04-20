class_name Projectile extends Path2D

## Величина наносимого урона
@export var attack_power: int = 10

## Радиус поражения
@export var damage_radius: float = 100

## Скорость движения снаряда
@export var move_speed: float = 200.0

# Логика расчетов баллистической траектории
var ballistics: Ballistics


func _ready():
	($PathFollow2D/DamageArea/CollisionShape2D.shape as CircleShape2D).radius = damage_radius
	if ballistics:
		var tween = $PathFollow2D.create_tween()
		tween.tween_method(_progress_ratio_animation, 0.0, 1.0, ballistics.time) \
			.set_trans(Tween.TRANS_LINEAR)
		tween.finished.connect(_destroy)


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


## Обработчик окончания полёта по траектории
func _destroy():
	apply_damage()
	queue_free()


## Наносим дамаг всем в зоне поражения
func apply_damage():
	for enemy in get_tree().get_nodes_in_group("enemies"):
		var d = enemy.global_position.distance_to($PathFollow2D/DamageArea.global_position)
		if d <= damage_radius:
			enemy.take_damage(attack_power)
