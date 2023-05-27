extends "res://towers/BaseTower/base_tower.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Flame/AnimatedSprite2D.animation = "Idle"


func _draw():
	pass


func _on_flame_damage_area_body_entered(body):
	pass # Replace with function body.


