class_name RangedEnemy extends Enemy

## Тип патрона
@export var projectile_type: PackedScene


func attack():
	var projectile = projectile_type.instantiate() as Projectile
	projectile.fire($AttackPivot.position, to_local(attack_target.global_position))
	call_deferred("add_child", projectile)
	$AttackTimer.start()

