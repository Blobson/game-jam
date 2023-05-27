extends "res://towers/BaseTower/base_tower.gd"



# Called when the node enters the scene tree for the first time.
func _ready():
	$Flame/AnimatedSprite2D.animation = "Idle"
	attack_power = 5


func _draw():
	pass


func _on_flame_damage_area_body_entered(body):
	attack(body)


func _on_damage_area_body_entered(body):
	if body.is_in_group("enemies"):
		_enemies_in_range.append(body)
		$Flame/AnimatedSprite2D.animation = "Work"


func _on_damage_area_body_exited(body):
	if body.is_in_group("enemies"):
		_enemies_in_range.erase(body)
		if _enemies_in_range.size() == 0:
			$Flame/AnimatedSprite2D.animation = "Idle"


func attack(body):
	pass
