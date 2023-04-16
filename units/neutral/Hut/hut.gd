class_name Hut extends Node2D

@export var health: int = 100
@export var attack_power: int
@export var jump_attack_power: int = 50

@onready var hp_indicator = get_node("/root/game/ui/HealthPointerIndicator/")

var enemies_in_melee_attack_area = []


func _init():
	add_to_group("Hut")

func _ready():
	$AnimationPlayer.play("idle")


func _on_hit_box_body_entered(body):
	if body is Enemy:
		take_damage((body as Enemy).attack_power)


func take_damage(damage):
	health -= damage
	hp_indicator.update_pointer_value(health)
	if health <= 0:
		queue_free()


func jump_attack():
	for enemy in enemies_in_melee_attack_area:
		enemy.take_damage(jump_attack_power)


func hut_repair():
	if health < 80:
		health += 20
		hp_indicator.update_pointer_value(health)
	elif health > 80 and health < 100:
		health = 100
		hp_indicator.update_pointer_value(health)


func _on_melee_attack_area_body_entered(body):
	if body.is_in_group("enemies"):
		print_debug("Something entered in HUT area:" + body.name)
		enemies_in_melee_attack_area.append(body)


func _on_melee_attack_area_body_exited(body):
	if body.is_in_group("enemies"):
		enemies_in_melee_attack_area.erase(body)
		print_debug("Something exited from HUT area:" + body.name)
