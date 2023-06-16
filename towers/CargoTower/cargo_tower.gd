extends "res://towers/BaseTower/base_tower.gd"


func _ready():
	$AnimationPlayer.play("idle") 
	$DamageArea.body_entered.connect(_on_damage_area_body_entered)
	$DamageArea.body_exited.connect(_on_damage_area_body_exited)
	

#Запускаем анимацию работы и таймер задержки
func start_attack(enemies_in_range: Array[Enemy]):
	$AnimationPlayer.play("work")
	$DelayTimer.start(0.5)


#Остановка атаки
func stop_attack():
	$AnimationPlayer.play("idle")
	$DelayTimer.stop()
	$AttackTimer.stop()


#По таймауту таймера запускаем атаку врагов в зоне действия груза
func _on_delay_timer_timeout():
	attack(_enemies_in_range)
	$CargoSFX.play()
	$AttackTimer.start(4.5)


#Атака врагов
func attack(enemies_in_range):
	for enemy in enemies_in_range:
		enemy.take_damage(attack_power)


#По таймауту таймера атаки проверяем размер массива и запускаем таймер задержки
func _on_attack_timer_timeout():
	if _enemies_in_range.size() == 0:
		stop_attack()
	else:
		$DelayTimer.start(0.5)
