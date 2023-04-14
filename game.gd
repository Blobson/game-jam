extends Node2D

var tower_build_menu
var current_build_location

@onready var current_level = $Level1

var towers = {
	"tower_1": "res://towers/TestTower/test_tower.tscn",
	"tower_2": "res://towers/TowerSaw/tower_saw.tscn"
	}


# Called when the node enters the scene tree for the first time.
func _ready():
	tower_build_menu = load("res://ui/TowerBuildlMenu/tower_build_menu.tscn").instantiate()
	$BackgroundMusic.play()
#	current_level.print_tree_pretty()

	# прописать обработку нажатий на TowerBuildLocation
	for child in current_level.get_children():
		if child is TowerBuildLocation:
			child.TowerBuildLocationClick.connect(_on_TowerBuildLocationClick)


func _on_TowerBuildLocationClick(build_location):
	current_build_location = build_location
	current_level.remove_child(build_location)

	# connect signals
	tower_build_menu.BuildMenu_Close.connect(_on_BuildMenu_Close)
	tower_build_menu.BuildMenu_TowerSelected.connect(_on_BuildMenu_TowerSelected)

	# show menu
	tower_build_menu.position = build_location.position
	current_level.add_child(tower_build_menu)


# Обработка выбора башни в меню постройки
func _on_BuildMenu_TowerSelected(tower):
	print_debug("Handle BuildMenu_TowerSelected(): tower=" + tower)
	current_level.remove_child(tower_build_menu)
	if tower in towers:
		var twr = load(towers[tower]).instantiate()
		twr.position = tower_build_menu.position
		add_child(twr)
	else:
		print("Tower '%s' not found".format(tower))


# Обработка закрытия меню постройки башни без выбора башни
func _on_BuildMenu_Close():
	print_debug("Handle BuildMenu_Close()")
	current_level.remove_child(tower_build_menu)
	current_level.add_child(current_build_location)
