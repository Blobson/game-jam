extends Node2D

## Величина наносимого урона
@export var attack_power: int = 10

## Группа врагов, которым наносится урон
@export var damage_groups: Array[String] = ['enemies']

## Радиус поражения
@export var damage_radius: float = 0

## Максимальная длинна луча
@export var max_lenght = 2000

## Сцена взрыва снаряда
@export var explosion_scene: PackedScene


func ready():
	$PathFollow2D/ImpactDetector.body_entered.connect(_on_impact)


func fire(body: Node2D):
	var start_position = $BeginElectricLine.global_position
	var target_position = body.global_position
	var electric_line_dir = target_position - start_position
	var max_cast_to = target_position.normalized() * max_lenght
	$RayCast2D.cast_to = max_cast_to * electric_line_dir 
	if $RayCast2D.is_colliding():
		$EndLaserLine.global_position = $RayCast2D.get_collision_point()
	else:
		$EndLaserLine.global_position = $RayCast2D.cast_to
	$LaserLine.rotation = $RayCast2D.cast_to.angle()
	$LaserLine.region_rect.end.x = $EndLaserLine.position.lenght()


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


func apply_unit_damage(body: Node2D):
	body.take_damage(attack_power)


func is_suitable_target(body: Node2D):
	if not body or not body.has_method("take_damage"):
		return false
	if body.has_method("is_dead") and body.is_dead():
		return false
	for group in damage_groups:
		if body.is_in_group(group):
			return true
	return false

