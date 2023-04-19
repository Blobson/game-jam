class_name Enemy extends CharacterBody2D

## Скорость движения моба
@export var move_speed: int = 150
## Здоровье моба
@export var health: int = 50
## Сила атаки моба
@export var attack_power: int = 10

var path_follower: EnemyPathFollower

@onready var hp_progress = $HpProgressBar
@onready var sprite = $Sprite2D


func _init():
	add_to_group("enemies")


func _ready():
	hp_progress.max_value = health
	hp_progress.step = health / 5
	hp_progress.value = health

	
## Установить новый EnemyPathFollower
func set_path_follower(follower: EnemyPathFollower):
	path_follower = follower
	position = path_follower.get_position()
	sprite.set("flip_h", path_follower.get_direction().x < 0)


## Перемещение
func move(delta: float):
	path_follower.follow_path(position, move_speed, delta)
	var dir = path_follower.get_direction()
	position += dir * move_speed * delta
	sprite.set("flip_h", dir.x < 0)


## Получение урона
func take_damage(damage_count):
	health -= damage_count
	hp_progress.value = max(0, health)
	
	if health <= 0:
		die()


## Смерть юнита
func die():
	queue_free()
	

func _process(delta: float):
	if path_follower:
		if path_follower.is_end_reached():
			path_follower = null
			queue_free() # TODO: здесь мы досигли избушки и должны начать её бить
		else:
			move(delta)
