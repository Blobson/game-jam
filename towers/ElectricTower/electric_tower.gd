class_name ElectricTower extends BaseTower

var electric_line_prefab = preload("res://towers/ElectricTower/ElectricLine/electric_line.tscn")
var load_time: float = 0.5

func _ready():
	$DamageArea.body_entered.connect(_on_damage_area_body_entered)
	$DamageArea.body_exited.connect(_on_damage_area_body_exited)
	$AttackTimer.timeout.connect(_on_attack_timer_timeout)


func attack(enemies_in_range: Array[Enemy]):
	# выбираем ближайшего врага
	var closest_enemy = find_closest_enemy(enemies_in_range)
	# прицеливаемся по врагу и стреляем
	if closest_enemy:
		fire(closest_enemy.global_position, closest_enemy.velocity)
	super.attack(enemies_in_range)


## Поиск ближайшего врага в зоне поражения
func find_closest_enemy(enemies_in_range: Array[Enemy]) -> Enemy:
	var distance: float = attack_distance * 2.0
	var closest_enemy: Enemy = null
	for enemy in enemies_in_range:
		if enemy.is_dead():
			continue
		var enemy_distance = enemy.global_position.distance_to(global_position)
		if enemy_distance <= distance:
			closest_enemy = enemy
			distance = enemy_distance
	return closest_enemy

## Стрельба по вражеским юнитам
func fire(target: Vector2, target_velocity: Vector2 = Vector2.ZERO):
	print('PEW')
	var electic_line = electric_line_prefab.instantiate()
	electic_line.position = $FirePivot.global_position
	get_parent().add_child(electic_line)
	$RayCast2D.cast_to = max_cast_to
	if $RayCast2D.is_colliding():
		$EndLaserLine.global_position = $RayCast2D.get_collision_point()
	else:
		$EndLaserLine.global_position = $RayCast2D.cast_to
		$LaserLine.rotation = $RayCast2D.cast_to.angle()
		$LaserLine.region_rect.end.x = $EndLaserLine.position.lenght()
	#target = to_local(target)
	
	#$AnimatedSprite2D.play("Work")
	
	#var tween = create_tween()
	#tween.tween_callback(rock.fire.bind($FirePivot.position, target)).set_delay(load_time)
	#await tween.finished
	
	#call_deferred("add_child", electic_line)
	#await $AnimatedSprite2D.animation_finished
	#$AnimatedSprite2D.play("Idle")



