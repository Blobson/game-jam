extends Node2D

@onready var current_level = get_node("/root/game/level").get_child(0)


# Called when the node enters the scene tree for the first time.
func _ready():
	#устанавливаем позицию камеры по центру картинки заднего плана
	$Camera.position = current_level.get_node("Background").position
	$BackgroundMusic.play()

