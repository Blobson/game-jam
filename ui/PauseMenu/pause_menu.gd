extends Node2D


func _ready():
	pass # Replace with function body.


func _on_continue_button_pressed():
	pass # Replace with function body.


func _on_settings_button_pressed():
	pass 


func _on_back_to_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://ui/MainMenu/main_menu.tscn")
