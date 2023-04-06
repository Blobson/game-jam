class_name Hut extends Node2D

@export var health: int = 100
@export var attack_force: int


func _ready():
	pass # Replace with function body.


func _on_hit_box_body_entered(body):
	var damage: int
	body.attack_force = damage
	damage_taken(damage)


func damage_taken(damage):
	health -= damage
	if health <= 0:
		queue_free()
