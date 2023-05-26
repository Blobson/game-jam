class_name RangedEnemy extends Enemy

## Тип патрона
@export var projectile_type: PackedScene


func attack():
	if attack_target != null:
		var projectile = projectile_type.instantiate() as Projectile
		projectile.fire($FirePivot.position, to_local(attack_target.global_position))
		call_deferred("add_child", projectile)
	super.attack()
	if attack_target != null:
		$AttackTimer.start()
