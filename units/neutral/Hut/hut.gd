class_name Hut extends StaticBody2D

@export var health: int = 100 :
	set(value):
		if health != value:
			Game.hut_health_changed.emit(health, value)
			health = value

@export var attack_power: int
@export var jump_attack_power: int = 50

@onready var hut_explosion = preload("res://units/neutral/Hut/HutExplosion/hut_explosion.tscn")

var enemies_in_melee_attack_area = []


func _init():
	add_to_group("hut")


func _ready():
	$MeleeAttackArea.body_entered.connect(_on_melee_attack_area_body_entered)
	$MeleeAttackArea.body_exited.connect(_on_melee_attack_area_body_exited)
	$AnimationPlayer.play("idle")
	$SteamHissSFX.play()


func take_damage(damage):
	if health > 0:
		health -= damage
		if health <= 0:
			die()


func is_dead() -> bool:
	return health == 0


func die():
	health = 0
	var explosion = hut_explosion.instantiate()
	explosion.position = global_position
	NodeUtils.replace_node(self, explosion)


func jump_attack():
	for enemy in enemies_in_melee_attack_area:
		enemy.take_damage(jump_attack_power)


func hut_repair():
	if health < 80:
		health += 20
	elif health > 80 and health < 100:
		health = 100


func _on_melee_attack_area_body_entered(body):
	if body.is_in_group("enemies"):
		enemies_in_melee_attack_area.append(body)


func _on_melee_attack_area_body_exited(body):
	if body.is_in_group("enemies"):
		enemies_in_melee_attack_area.erase(body)
