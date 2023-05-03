class_name Enemy extends CharacterBody2D

## Скорость движения моба
@export var move_speed: int = 150
## Здоровье моба
@export var health: int = 50
## Сила атаки моба
@export var attack_power: int = 10
## Золото за убийство
@export var gold_cost: int = 10

@onready var hp_progress = $HpProgressBar
@onready var sprite = $Sprite2D

var path_follower: EnemyPathFollower

## Направление движения юнита
var move_direction: Vector2 :
	get:
		if path_follower:
			return path_follower.get_direction()
		return Vector2.ZERO


func _init():
	add_to_group("enemies")


func _ready():
	hp_progress.max_value = health
	hp_progress.value = health


## Установить новый EnemyPathFollower
func set_path_follower(follower: EnemyPathFollower):
	path_follower = follower
	position = path_follower.get_position()
	sprite.set("flip_h", path_follower.get_direction().x < 0)


## Перемещение
func move(delta: float):
	path_follower.follow_path(position, move_speed, delta)
	var dir = move_direction
	position += dir * move_speed * delta
	sprite.set("flip_h", dir.x < 0)
	queue_redraw()


## Получение урона
func take_damage(damage_count):
	health -= damage_count
	hp_progress.value = max(0, health)
	
	if health <= 0:
		die()


## Смерть юнита
func die():
	queue_free()
	Game.gold += gold_cost
	

func _process(delta: float):
	if path_follower:
		if path_follower.is_end_reached():
			path_follower = null
			queue_free() # TODO: здесь мы досигли избушки и должны начать её бить
		else:
			move(delta)
			

func _draw():
	draw_line(Vector2.ZERO, move_direction * move_speed, Color.DARK_RED)
