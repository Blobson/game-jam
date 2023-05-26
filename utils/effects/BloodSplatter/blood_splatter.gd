extends Node2D

## Время за которое лужа крови пропадает из сцены
@export var disappear_time = 10


func _ready():
	$AnimatedSprite2D.play("Bloodspray")
	$AudioStreamPlayer2D.play()
	$AnimatedSprite2D.animation_finished.connect(blood_puddle)


func blood_puddle():
	$AnimatedSprite2D.play("Puddle")
	# Постепенно увеличиваем прозрачность лужи крови и в конце удаляем её из сцены
	var tween = create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.TRANSPARENT, disappear_time)
	tween.finished.connect(queue_free)
