extends Node2D

# Сигнал выбора башни (нажата кнопка башни)
signal BuildMenu_TowerSelected
# Сигнал нажатия куда либо (т.е. должно закрыться меню)
signal BuildMenu_Close


# У TouchScreenButton должен быть прописан action с названием башни
# При нажатии на этот button тригерятся несколько ивентов
#  - InputEventAction с атрибутом action
#  - InputEventScreenTouch что кнопка нажата\отжата
func _input(event):
	# print(event)
	# print_tree_pretty()
	
	if event is InputEventAction && !event.is_pressed():
		BuildMenu_TowerSelected.emit(event.action)
		# var p = get_parent()
		# get_node("/root").set_input_as_handled()
				
	if event is InputEventScreenTouch && !event.is_pressed():
		BuildMenu_Close.emit()
