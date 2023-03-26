extends Node2D


func _on_music_slider_value_changed(value):
	var bus_index = AudioServer.get_bus_index("Music")
	print(bus_index)
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

