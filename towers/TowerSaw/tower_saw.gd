extends BaseTower


func start_attack(enemies_in_range: Array[Enemy]):
	$Tower/AnimatedSprite2D.animation = "Work"
	if not $TowerSawSFX.playing:
		$TowerSawSFX.pitch_scale = randf_range(0.9, 1.1)
		$TowerSawSFX.play()
	super.start_attack(enemies_in_range)


func attack(enemies_in_range: Array[Enemy]):
	for enemy in enemies_in_range:
		enemy.take_damage(attack_power)
	super.attack(enemies_in_range)


func stop_attack():
	$Tower/AnimatedSprite2D.animation = "Idle"
	$TowerSawSFX.stop()
	super.stop_attack()
