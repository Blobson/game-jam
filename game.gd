extends Node2D


func _enter_tree():
	# Загружаем последний сохранённый уровень
	Game.load_level()


func _ready():
	# Устанавливаем позицию камеры по центру картинки заднего плана
	$Camera.position =  Game.level.get_node("Background").position
	$BackgroundMusic.play()

