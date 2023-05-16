extends "res://utils/Projectile/projectile.gd"

@onready var explosion_scene = load("res://towers/CatapultTower/RockExplosion/rock_explosion.tscn")


func _destroy():
	var explosion = explosion_scene.instantiate()
	$PathFollow2D/Sprite2D.replace_by(explosion)
	apply_damage()
	$QueueTimer.start(2)


func _on_queue_timer_timeout():
	queue_free()
