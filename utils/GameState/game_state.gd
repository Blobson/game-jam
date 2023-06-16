extends Node

signal gold_changed(from, to)
signal hut_health_changed(from, to)
signal gameover

## Номер текущего уровня
var level_id: int = 1

## Текущий уровень
var level: Node2D

## Битовые флаги дебага
enum { 
	DRAW_UNIT_VELOCITY = 1, 
	DRAW_TOWER_ATTACK_ZONES = 2 
}
var debug_flags: int = DRAW_UNIT_VELOCITY | DRAW_TOWER_ATTACK_ZONES

## Доступное золото
var gold: int = 0 :
	set(value):
		if gold != value:
			var old = gold
			gold = value
			gold_changed.emit(old, gold)

# Место сохранения по-умолчанию
var _save_path: String = "user://default.save"


func _enter_tree():
	load_state(_save_path)
	

func _exit_tree():
	save_state(_save_path)


## Загрузка уровня
func load_level(new_level_id: int = -1) -> Node2D:
	if new_level_id == -1:
		new_level_id = level_id
	var level_scene_path = "res://levels/Level%d/level%d.tscn" % [new_level_id, new_level_id]
	var level_scene = load(level_scene_path)
	if level_id != new_level_id:
		gold = 0
		level_id = new_level_id
	var level_container = get_node("/root/game/level")
	for child in level_container.get_children():
		child.queue_free()
	level = level_scene.instantiate()
	level_container.add_child(level)
	return level


## Получить ссылку на избушку
func getHut() -> Hut: 
	return Game.level.get_node("Hut") as Hut
	

## Выход из игры
func quit():
	get_tree().quit()


## Сохранение игрового состояния
func save_state(filename: String):
	var file = FileAccess.open(filename, FileAccess.WRITE)
	var state = {
		"level": level_id,
	}
	var state_json = JSON.stringify(state)
	file.store_string(state_json)
	file.close()


## Загрузка игрового состояния
func load_state(filename: String):
	if FileAccess.file_exists(filename):
		var state_json = FileAccess.get_file_as_string(filename)
		var state = JSON.parse_string(state_json)
		level_id = state['level']
