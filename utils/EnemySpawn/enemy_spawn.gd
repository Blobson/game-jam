class_name EnemySpawn extends Node2D

@export var enemy_type: PackedScene :
	get:
		return enemy_type
	set(new_enemy_type):
		if enemy_type != new_enemy_type:
			enemy_type = new_enemy_type
			queue_redraw()

## Количество врагов в волне
@export var enemy_count: int = 1

## Максимальное кол-во волн (0 - бесконечно)
@export var enemy_waves_count: int = 0

## Время первой волны
@export var first_wave_time: float = 15.0

## Время между волнами
@export var wave_timeout: float = 30.0

## Случайная задержка между спавном юнитов в волне
@export var wave_spawn_random: float = 1.0

## Рельса для спавна врагов
@onready var _path: EnemyPath = get_parent()

var _enemies_to_spawn: int = 0
var _next_spawn_timeout: float = 0
var _next_wave_timeout: float = 0


func _ready():
	_schedule_wave(first_wave_time)
	

func _schedule_wave(timeout: float):
	_enemies_to_spawn = 0
	_next_spawn_timeout = 0
	_next_wave_timeout = timeout


func _process(delta):
	if _next_wave_timeout > 0:
		_next_wave_timeout -= delta
		if _next_wave_timeout <= 0:
			# запустить волну
			_enemies_to_spawn = enemy_count

	if _enemies_to_spawn > 0:
		if _next_spawn_timeout > 0:
			_next_spawn_timeout -= delta
		
		if _next_spawn_timeout <= 0:
			# спавним нового врага
			var enemy = enemy_type.instantiate()
			_path.add_child(enemy)
			enemy.set_path_follower(_path.create_follower())
			_enemies_to_spawn -= 1
			_next_spawn_timeout = randf_range(0.0, wave_spawn_random)

			if _enemies_to_spawn == 0:
				# запускаем ожидание следующей волны
				_schedule_wave(wave_timeout)


func _get_configuration_warnings() -> PackedStringArray:
	var warnings = PackedStringArray()
	if !enemy_type:
		warnings.append("Enemy Type is not specified")
	return warnings
