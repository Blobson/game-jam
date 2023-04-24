extends Node2D

var gamesaved: bool = false #наличие сохранений в игре. Когда игрок создаст сохранение, должна поменяться в 1.

func _ready():
	$CanvasLayer/Buttons/ContinueButton.grab_focus() #Подсвечена кнопка 'продолжить' при запуске
	game_saved_test()
	$MainTheme.play()


func game_saved_test(): #проверка наличия сохранений
	if not gamesaved:
		$CanvasLayer/Buttons/ContinueButton.visible = false 
		$CanvasLayer/Buttons/NewGameButton.grab_focus()
	else:
		$CanvasLayer/Buttons/ContinueButton.visible = true		


func _on_continue_button_pressed():
	get_tree().change_scene_to_file("saved level") #запуск сохраненного уровня


func _on_new_game_button_pressed():
	get_tree().change_scene_to_file("level1") #запуск 1го уровня


func _on_settings_button_pressed():
	get_tree().change_scene_to_file("res://ui/SettingsMenu/settings.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
