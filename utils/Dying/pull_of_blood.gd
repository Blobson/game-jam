extends Node2D

@onready var blood_puddle_time: int = 2

func _ready():
	$AnimatedSprite2D.play("Bloodspray")
	$AudioStreamPlayer2D.play()


func _on_animated_sprite_2d_animation_finished():
	$AnimatedSprite2D.play("Puddle")

