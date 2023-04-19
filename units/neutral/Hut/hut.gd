class_name Hut extends Node2D

@export var health: int = 100
@export var attack_force: int


func _ready():
	$AnimationPlayer.play("idle")


func _on_hit_box_body_entered(body):
	if body is Enemy:
		take_damage((body as Enemy).attack_power)


func take_damage(damage):
	health -= damage
	if health <= 0:
		queue_free()
