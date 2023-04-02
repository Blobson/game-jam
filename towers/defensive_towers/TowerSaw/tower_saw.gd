extends BaseTower

class_name TowerSaw

@export var health: int = 50  #здоровье башни
@export var attack_force: int = 5   #сила атаки башни

var damaged_enemies = []     #враги в зоне пил


func _ready():
	$Tower/AnimatedSprite2D.animation = "Idle"


func _process(delta):
	if damaged_enemies.size() > 0:
		attack()


func _on_hit_box_body_entered(body): #получение урона башней (разрушение)
	pass


func _on_damage_area_area_entered(area):
	if area.get_parent().has_method("take_damage"):
		$Tower/AnimatedSprite2D.animation = "Work"
		damaged_enemies.append(area.get_parent())
		print_debug("Something entered in my area:" + area.get_parent().name)
	

func _on_damage_area_area_exited(area):
	if area.get_parent().has_method("take_damage"):
		damaged_enemies.erase(area.get_parent())
		print_debug("Something exited from my area:" + area.get_parent().name)
		if damaged_enemies.size() == 0:
			$Tower/AnimatedSprite2D.animation = "Idle"


##Атака противника
func attack():
	$DamageTimer.start(3.0)
	for enemy in damaged_enemies:
		enemy.take_damage(attack_force)



func _on_damaged_timer_timeout():
	attack()

