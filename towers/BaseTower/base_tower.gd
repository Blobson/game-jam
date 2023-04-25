class_name BaseTower extends Node2D

## Здоровье башни
@export var health: int = 100

## Сила атаки башни
@export var attack_power: int = 10

## Время между атаками башни
@export var attack_interval: float = 1 :
	set(value):
		if value != attack_interval:
			attack_interval = value
			if $AttackTimer:
				$AttackTimer.wait_time = value

## Радиус атаки башни
@export var attack_distance: float = 500 :
	get:
		var collision_shape = $DamageArea/CollisionShape2D
		if collision_shape:
			var shape = collision_shape.shape as CircleShape2D
			if shape:
				return shape.radius
		return 0
	set(value):
		var collision_shape = $DamageArea/CollisionShape2D
		if collision_shape:
			var shape = collision_shape.shape as CircleShape2D
			if shape and shape.radius != value:
				shape.radius = value
				queue_redraw()

## Враги в зоне досягаемости башни
var _enemies_in_range: Array[Enemy] = []


func _ready():
	$DamageArea.body_entered.connect(_on_damage_area_body_entered)
	$DamageArea.body_exited.connect(_on_damage_area_body_exited)
	$AttackTimer.timeout.connect(_on_attack_timer_timeout)


func _draw():
	var shape = $DamageArea/CollisionShape2D.shape as CircleShape2D
	draw_set_transform_matrix($DamageArea.transform * $DamageArea/CollisionShape2D.transform)
	draw_arc(Vector2.ZERO, shape.radius, 0, TAU, 100, Color(0, 0.7, 0.7, 0.3), 7, true)


func _on_damage_area_body_entered(body):
	if body.is_in_group("enemies"):
		_enemies_in_range.append(body)
		if _enemies_in_range.size() == 1:
			start_attack(_enemies_in_range)


func _on_damage_area_body_exited(body):
	if body.is_in_group("enemies"):
		_enemies_in_range.erase(body)
		if _enemies_in_range.size() == 0:
			stop_attack()


func _on_attack_timer_timeout():
	if _enemies_in_range.size() == 0:
		stop_attack()
	else:
		start_attack(_enemies_in_range)


## Override to implement attacking mechanics
func start_attack(enemies_in_range: Array[Enemy]):
	if $AttackTimer.is_stopped():
		$AttackTimer.start()
		attack(enemies_in_range)


## Override to implement attacking mechanics
@warning_ignore("unused_parameter")
func attack(enemies_in_range: Array[Enemy]):
	pass


## Override to implement attacking mechanics
func stop_attack():
	pass

