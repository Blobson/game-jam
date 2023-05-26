class_name BaseUnit extends CharacterBody2D


## Скорость движения
@export var move_speed: int = 100
## Здоровье
@export var health: int = 50
## Сила атаки
@export var attack_power: int = 10
## Группы юнитов, которые должны быть
@export var attackable_groups: Array[String] = []
## Сцена кровавой лужи после смерти юнита
@export var blood_scene: PackedScene

enum UnitState {IDLE, WALKING, ATTACKING, DEAD}
var state: UnitState = UnitState.IDLE
var targets_in_range: Array[Node] = []
var attack_target: Node = null


func _init():
	add_to_group("units")


func _draw():
	if Game.debug_flags & Game.DRAW_UNIT_VELOCITY:
		draw_line(Vector2.ZERO, velocity, Color.DARK_RED)


func _ready():
	$HealthBar.max_value = health
	$HealthBar.value = health
	$AttackTimer.timeout.connect(attack)
	$AttackArea.body_entered.connect(_on_attack_area_body_entered)
	$AttackArea.body_exited.connect(_on_attack_area_body_exited)


func _physics_process(_delta):
	if not is_dead():
		move_and_slide()
		$Sprite2D.set("flip_h", velocity.x < 0)
	if Game.debug_flags:
		queue_redraw()


## Признак смерти юнита
func is_dead() -> bool:
	return state == UnitState.DEAD


## Получение урона
func take_damage(damage_count):
	if not is_dead():
		health -= damage_count
		$HealthBar.value = max(0, health)
		if health <= 0:
			die()


## Смерть юнита
func die():
	$AnimationPlayer.stop()
	state = UnitState.DEAD
	velocity = Vector2.ZERO
	$HealthBar.visible = false

	# Заменяем юнит на лужу крови
	var blood = blood_scene.instantiate()
	blood.position = position
	NodeUtils.replace_node(self, blood)


## Действия при атаке
func attack():
	if attack_target != null and attack_target.has_method("is_dead") \
			and attack_target.is_dead():
		targets_in_range.erase(attack_target)
		attack_target = null
				
	if attack_target != null:
		$AttackTimer.start()
	else:
		state = UnitState.IDLE

## Обнаружение юнитов в зоне видимости
func _on_attack_area_body_entered(body: Node):
	if is_dead():
		return
	if is_attackable_target(body):
		targets_in_range.append(body)
		if state not in [UnitState.ATTACKING]:
			select_next_target()


## Обнаружение юнитов покинувших зону видимости
func _on_attack_area_body_exited(body):
	targets_in_range.erase(body)


func is_attackable_target(body: Node) -> bool:
	if body.has_method("is_dead") and body.is_dead():
		return false
	for group in attackable_groups:
		if body.is_in_group(group):
			return true
	return false


## Выбор следующей цели
func select_next_target():
	attack_target = null
	var attack_target_distance = 9223372036854775807
	for target in targets_in_range:
		if target.has_method("is_dead") and target.is_dead():
			continue
		var distance = global_position.distance_to(target.global_position)
		if distance < attack_target_distance:
			attack_target = target
			attack_target_distance = distance
	if attack_target != null:
		state = UnitState.ATTACKING
		velocity = Vector2.ZERO
		attack()
	else:
		state = UnitState.IDLE
