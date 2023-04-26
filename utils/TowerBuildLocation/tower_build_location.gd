class_name TowerBuildLocation extends Node2D

@onready var build_menu = get_node("/root/game/ui/TowerBuildMenu")


# Установка башни на месте BuildLocation
func put_tower(twr):
		twr.position = position

		var parent = get_parent()
		var pos_in_parent = get_index()
		
		parent.remove_child(self)
		parent.add_child(twr)
		parent.move_child(twr, pos_in_parent)

		call_deferred("free")

# Нажатие на Location
func _on_touch_screen_button_pressed():
	build_menu.show_menu(self)
	
