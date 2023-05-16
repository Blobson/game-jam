class_name Explosion extends Node2D


func _ready():
	$AnimationPlayer.play("explosion")
	$ExplosionSFX.pitch_scale = randf_range(0.8, 1.2)
	$ExplosionSFX.play()


func _on_animation_player_animation_finished(explosion):
	queue_free()
	
