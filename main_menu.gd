extends Node2D


func _ready():
	$CanvasLayer/Buttons/Continue.grab_focus() #Подсвечена кнопка 'продолжить' при запуске
	$CanvasLayer/Settings.visible = false

func _process(delta):
	pass


func _on_continue_pressed():
	get_tree().change_scene_to_file('none') #Запуск текущего уровня (последнее сохранение)


func _on_new_game_pressed():
	get_tree().change_scene_to_file('none') #Запуск 1го уровня


func _on_settings_pressed():
	$CanvasLayer/Buttons.visible = false
	$CanvasLayer/Settings.visible = true
	$CanvasLayer/Settings/SettingsElements/BackToMenu.grab_focus()


func _on_quit_pressed():
	get_tree().quit()


func _on_back_to_menu_pressed():  #button BackToMenu in scene Settings/SettingsElement
	$CanvasLayer/Settings.visible = false
	$CanvasLayer/Buttons.visible = true
	$CanvasLayer/Settings/SettingsElements/BackToMenu.grab_focus()
