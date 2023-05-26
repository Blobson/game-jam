@tool class_name CatapultTower extends BaseTower

var _rock_prefab = preload("res://towers/CatapultTower/Rock/rock.tscn")
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
	target = to_local(target)
	var rock = _rock_prefab.instantiate() as Projectile
	if target_velocity != Vector2.ZERO:
		# Вычисляем куда предположительно переместится цель за время полёта снаряда
		var time = rock.time_to_target($FirePivot.position, target)
		target += target_velocity * (time + load_time)
	$AnimatedSprite2D.play("Work")
	
	var tween = create_tween()
	tween.tween_callback(rock.fire.bind($FirePivot.position, target)).set_delay(load_time)
	await tween.finished
	
	call_deferred("add_child", rock)

	await $AnimatedSprite2D.animation_finished
	$AnimatedSprite2D.play("Idle")

