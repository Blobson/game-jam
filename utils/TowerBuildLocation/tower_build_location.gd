class_name TowerBuildLocation extends Node2D

signal TowerBuildLocationClick


func _on_touch_screen_button_pressed():
	emit_signal("TowerBuildLocationClick", self)
