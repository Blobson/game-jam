class_name Enemy extends CharacterBody2D

signal enemy_reached_target

@export var move_speed: int = 100

var _path: EnemyPath
var _path_offset: float


func set_path(path: EnemyPath):
	_path = path
	position = _path.start_position()
	print_debug("Spawning '{name}' at path '{path}' in coords {pos}".format({
		"name": name, 
		"path": _path.name,
		"pos": position,
	}))

	
## Метод следования по заданному пути.
## Если достигнут конец пути, возвращает true
func follow_path(delta: float) -> bool:
	if _path_offset == null:
		_path_offset = _path.curve.get_closest_offset(position)
	_path_offset += move_speed * delta
	
	# ищем целевую точку на рельсе
	var target_transform = _path.curve.sample_baked_with_rotation(_path_offset)
	
	# постепенно двигаемся к цели
	_move_to(target_transform)
	
	# проверяем достигнут ли конец пути
	return transform.origin.is_equal_approx(_path.end_position())


## Перемещение в целевую точку
func _move_to(target_transform: Transform2D):
	position = target_transform.origin
	

func _process(delta: float):
	if _path and follow_path(delta):
		enemy_reached_target.emit()
		queue_free()
