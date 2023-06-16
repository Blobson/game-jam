extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	visible = false
	Game.gameover.connect(_on_gameover)


func _on_try_again_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")
	get_tree().paused = false


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://ui/MainMenu/main_menu.tscn")

func _on_gameover():
	$GameOverMenuTimer.start(2)


func _on_game_over_menu_timer_timeout():
	visible = true
	get_tree().paused = true
