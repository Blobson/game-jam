class_name EnemyPathFollower extends RefCounted

var path: EnemyPath
var _offset_from_center: int
var _transform: Transform2D


func _init(enemy_path: EnemyPath):
	self.path = enemy_path
	# вычисляем случайное смещение от центра дороги
	# TODO: подумать о формациях или спавне с распределением по дороге
	@warning_ignore("integer_division")
	_offset_from_center = randi() % path.width - path.width / 2
	# получаем стартовую трансформацию
	_transform = path.curve.sample_baked_with_rotation(0)


## Метод следования по EnemyPath
func follow_path(current_position: Vector2, _speed: float, _time_delta: float):
	var offset_from_start = path.curve.get_closest_offset(current_position)
	_transform = path.curve.sample_baked_with_rotation(offset_from_start)


## Проверка достижения конца пути
func is_end_reached():
	return _transform.origin.is_equal_approx(path.end_position())


## Получить текущую позицию со смещением от центра дороги
func get_position():
	var normal = get_direction().orthogonal() 
	return _transform.origin + normal * _offset_from_center


## Получить текущее направление движения
func get_direction():
	return Vector2.UP.rotated(_transform.get_rotation())
