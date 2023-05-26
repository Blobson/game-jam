class_name Explosion extends Node2D


func _ready():
	$ExplosionSprite.play("Explosion") #Важно дать название анимации - Explosion
	$ExplosionSFX.pitch_scale = randf_range(0.8, 1.2)
	$ExplosionSFX.play()
	# Удаляем ноду по окончании проирывания звука
	$ExplosionSFX.finished.connect(queue_free)
