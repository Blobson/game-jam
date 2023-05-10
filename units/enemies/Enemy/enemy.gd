class_name Enemy extends CharacterBody2D

## Скорость движения моба
@export var move_speed: int = 150
## Здоровье моба
@export var health: int = 50
## Сила атаки моба
@export var attack_power: int = 10
## Золото за убийство
@export var gold_reward: int = 10

@onready var hp_progress = $HpProgressBar
@onready var sprite = $Sprite2D

var path_follower: EnemyPathFollower
var targets_in_range = []
enum EnemyState {WALKING, ATTACKING, DIEING, DEAD}
var state = EnemyState.WALKING
var attack_target = null


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
	$AttackTimer.timeout.connect(attack)
	$DamageArea.body_entered.connect(_on_damage_area_body_entered)
	$DamageArea.body_exited.connect(_on_damage_area_body_exited)


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
	Game.gold += gold_reward
	

func _process(delta: float):
	if path_follower and state == EnemyState.WALKING:
		if path_follower.is_end_reached():
			path_follower = null
			queue_free() # TODO: здесь мы досигли избушки и должны начать её бить
		else:
			move(delta)
			

func _draw():
	draw_line(Vector2.ZERO, move_direction * move_speed, Color.DARK_RED)


## Обнаружение тела в области
func _on_damage_area_body_entered(body):
	if body.name == 'HutBody' and state not in [EnemyState.DEAD, EnemyState.DIEING]:
		targets_in_range.append(body)
		if state not in [EnemyState.ATTACKING]:
			select_next_target()
		


## Выход тела из области
func _on_damage_area_body_exited(body):
	targets_in_range.erase(body.get_parent())


## Поиск следующей цели
func find_target():
	var selected_target = null
	var selected_target_distance = ($DamageArea/CollisionShape2D.shape as CircleShape2D).radius * 2
	for target in targets_in_range:
		var distance = global_position.distance_to(target.global_position)
		if distance < selected_target_distance:
			selected_target = target
			selected_target_distance = distance
	return selected_target
	

func select_next_target():
	attack_target = find_target()
	if attack_target != null:
		state = EnemyState.ATTACKING
		attack()
	else:
		state = EnemyState.WALKING
	

func attack():
	pass
