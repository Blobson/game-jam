class_name TowerSaw extends BaseTower

@export var health: int = 50  #здоровье башни
@export var attack_power: int = 15   #сила атаки башни

var enemies_in_damage_area = []     #враги в зоне пил


func _ready():
	$Tower/AnimatedSprite2D.animation = "Idle"


func _process(delta):
	pass


func _on_hit_box_body_entered(body): #получение урона башней (разрушение)
	pass


func _on_damage_area_body_entered(body):
	if enemies_in_damage_area.size() == 0:
		if body.is_in_group("enemies"):
			$Tower/AnimatedSprite2D.animation = "Work"
			enemies_in_damage_area.append(body)
			print_debug("Something entered in my area:" + body.name)
			if enemies_in_damage_area.size() > 0:  
				attack()
	elif enemies_in_damage_area.size() > 0:
		enemies_in_damage_area.append(body)


func _on_damage_area_body_exited(body):
	if body.is_in_group("enemies"):
		enemies_in_damage_area.erase(body)
		print_debug("Something exited from my area:" + body.name)
		if enemies_in_damage_area.size() == 0:
			$Tower/AnimatedSprite2D.animation = "Idle"


func attack():
	$AttackTimer.start(3.0)
	for enemy in enemies_in_damage_area:
		enemy.take_damage(attack_power)


func _on_attack_timer_timeout():
	attack()



