extends Node2D

## Величина наносимого урона
@export var attack_power: int = 10

## Группа врагов, которым наносится урон
@export var damage_groups: Array[String] = ['enemies']

## Максимальная длинна луча
@export var max_lenght = 2000

func ready():
	pass

func apply_unit_damage(body: Node2D):
	body.take_damage(attack_power)

#func fire():
	var start_position = Vector2.ZERO
	var max_cast_to = start_position * max_lenght
	$RayCast2D.cast_to = max_cast_to
	if $RayCast2D.is_colliding():
		$EndLaserLine.global_position = $RayCast2D.get_collision_point()
	else:
		$EndLaserLine.global_position = $RayCast2D.cast_to
		$LaserLine.rotation = $RayCast2D.cast_to.angle()
		$LaserLine.region_rect.end.x = $EndLaserLine.position.lenght()


func is_suitable_target(body: Node2D):
	if not body or not body.has_method("take_damage"):
		return false
	if body.has_method("is_dead") and body.is_dead():
		return false
	for group in damage_groups:
		if body.is_in_group(group):
			return true
	return false

