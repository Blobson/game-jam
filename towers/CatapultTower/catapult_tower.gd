@tool class_name CatapultTower extends BaseTower

var _rock_prefab = preload("res://towers/CatapultTower/Rock/rock.tscn")
var preload_timer_value: float = 0.5


func _ready():
	$DamageArea.body_entered.connect(_on_damage_area_body_entered)
	$DamageArea.body_exited.connect(_on_damage_area_body_exited)
	$AttackTimer.timeout.connect(_on_attack_timer_timeout)
	$Tower/AnimatedSprite2D.play("Idle")


func attack(enemies_in_range: Array[Enemy]):
	# выбираем ближайшего врага
	var closest_enemy = find_closest_enemy(enemies_in_range)
	# прицеливаемся по врагу и стреляем
	if closest_enemy:
		fire(closest_enemy.global_position, closest_enemy.move_direction * closest_enemy.move_speed)
	super.attack(enemies_in_range)


func _on_attack_timer_timeout():
	if _enemies_in_range.size() == 0:
		stop_attack()
	else:
		work_animation_preload_timer()


func _on_damage_area_body_entered(body):
	if body.is_in_group("enemies"):
		_enemies_in_range.append(body)
		if _enemies_in_range.size() == 1:
			work_animation_preload_timer()


##запуск анимации работы и таймера preload
func work_animation_preload_timer():
	$PreloadTimer.start(preload_timer_value)
	$Tower/AnimatedSprite2D.play("Work")


## Поиск ближайшего врага в зоне поражения
func find_closest_enemy(enemies_in_range: Array[Enemy]) -> Enemy:
	var distance: float = attack_distance * 1.5
	var closest_enemy: Enemy = null
	for enemy in enemies_in_range:
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
		target += target_velocity * time
	# Стреляем по цели
	rock.fire($FirePivot.position, target)
	call_deferred("add_child", rock)


func _on_animated_sprite_2d_animation_finished():
	$Tower/AnimatedSprite2D.play("Idle")


func _on_preload_timer_timeout():
	if $AttackTimer.is_stopped():
		$AttackTimer.start()
		attack(_enemies_in_range)
