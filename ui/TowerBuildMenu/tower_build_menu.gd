extends Container

var towers = {
	"tower_1": preload("res://towers/TowerSaw/tower_saw.tscn"),
	"tower_2": preload("res://towers/CatapultTower/catapult_tower.tscn")
}

var build_location: TowerBuildLocation = null


func _ready():
	# выключаем обработку ивентов пака меню не активно
	set_process_input(false)


# Показ меню для указанного build location
func show_menu(b: TowerBuildLocation):
	# включаем обработку ивентов
	set_process_input(true)
	position = b.position
	build_location = b
	show()


# Обработка выбора башни в меню постройки
func put_tower(tower):
	if tower in towers:
		var twr = towers[tower].instantiate()
		build_location.put_tower(twr)
	else:
		print_debug("Tower '%s' not found".format(tower))


# Обработка закрытия меню постройки башни без выбора башни
func close_menu():
	self.hide()
	set_process_input(false)


# У TouchScreenButton должен быть прописан action с названием башни
# При нажатии на этот button тригерятся несколько ивентов
#  - InputEventAction с атрибутом action
#  - InputEventScreenTouch что кнопка нажата\отжата
func _input(event):
	if event is InputEventAction && !event.is_pressed():
		put_tower(event.action)

	if event is InputEventScreenTouch && !event.is_pressed():
		close_menu()
