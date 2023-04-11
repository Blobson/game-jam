class_name Enemy extends CharacterBody2D

@export var move_speed: float = 150
@export var health: float = 50
@export var attack_power: int = 10
@export var max_health = health
var path_follower: EnemyPathFollower

func _init():
	add_to_group("enemies")


func _ready():
	max_health=health

	
## Установить новый EnemyPathFollower
func set_path_follower(path_follower: EnemyPathFollower):
	self.path_follower = path_follower
	position = path_follower.get_position()
	$Sprite2D.set("flip_h", path_follower.get_direction().x < 0)


## Перемещение
func _move(delta: float):
	path_follower.follow_path(position, move_speed, delta)
	var dir = path_follower.get_direction()
	position += dir * move_speed * delta
	$Sprite2D.set("flip_h", dir.x < 0)


## Получение урона
func take_damage(damage_count):
	print(health)
	health -= damage_count
	$HP_bar.set("value", (health/max_health)*$HP_bar.max_value)
	if health <= 0:
		queue_free() ##Смерть от получения урона


func _process(delta: float):
	if path_follower:
		if path_follower.is_end_reached():
			path_follower = null
			queue_free()
		else:
			_move(delta)
