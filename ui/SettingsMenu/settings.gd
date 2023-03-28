extends Node2D

func _ready():
	$SettingsElements/BackToMenuButton.grab_focus()


func _on_music_slider_value_changed(value):
	var bus_index = AudioServer.get_bus_index("Music")
	if value > $SettingsElements/MusicSlider.min_value:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, value)
	else:
		AudioServer.set_bus_mute(bus_index, true)	


func _on_sfx_slider_value_changed(value):
	var bus_index = AudioServer.get_bus_index("SFX")
	if value > $SettingsElements/SFXSlider.min_value:
		AudioServer.set_bus_mute(bus_index, false)
		AudioServer.set_bus_volume_db(bus_index, value)
	else:
		AudioServer.set_bus_mute(bus_index, true)	


func _on_back_to_menu_button_pressed():
	get_tree().change_scene_to_file("res://ui/MainMenu/main_menu.tscn")
