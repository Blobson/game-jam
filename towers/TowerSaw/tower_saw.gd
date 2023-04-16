class_name TowerSaw extends BaseTower

@export var health: int = 50  #здоровье башни
@export var attack_power: int = 15   #сила атаки башни
@export var debug_area_circle: bool = true

var enemies_in_damage_area = []     #враги в зоне пил


func _ready():
	$Tower/AnimatedSprite2D.animation = "Idle"
	if debug_area_circle:
		_draw()


#Damage_area_draw
func _draw():
	var shape = $DamageArea/CollisionShape2D.shape as CircleShape2D
	draw_set_transform_matrix($DamageArea.transform * $DamageArea/CollisionShape2D.transform)
	draw_arc(Vector2.ZERO, shape.radius, 0, TAU, 100, Color(0, 0.7, 0.7, 0.3), 7, true)


func _process(delta):
	pass


func _on_hit_box_body_entered(body): #получение урона башней (разрушение)
	pass


func _on_damage_area_body_entered(body):
	if body.is_in_group("enemies"):
		print_debug("Something entered in my area:" + body.name)
		enemies_in_damage_area.append(body)
		if enemies_in_damage_area.size() == 1:
			$Tower/AnimatedSprite2D.animation = "Work"
			$TowerSawSFX.pitch_scale = randf_range(0.9, 1.1)
			$TowerSawSFX.play()
			attack()


func _on_damage_area_body_exited(body):
	if body.is_in_group("enemies"):
		enemies_in_damage_area.erase(body)
		print_debug("Something exited from my area:" + body.name)
		if enemies_in_damage_area.size() == 0:
			$Tower/AnimatedSprite2D.animation = "Idle"
			$TowerSawSFX.stop()


func attack():
	$AttackTimer.start(3.0)
	for enemy in enemies_in_damage_area:
		enemy.take_damage(attack_power)


func _on_attack_timer_timeout():
	attack()



