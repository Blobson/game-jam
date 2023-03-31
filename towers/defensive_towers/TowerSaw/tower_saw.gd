extends "res://towers/BaseTower/base_tower.gd"

signal damage_saw(damage_dealt)

@export var health: int = 50
@export var damage_dealt: int = 5
@export var damage_taken: int = 2
var enemy = null				  # НУЖНО ПРИВЯЗАТЬ ВРАГА
var observed_enemies: int = 0    #счетчик наблюдаемых врагов
var damaged_enimies: int = 0	#счетчик врагов в зоне пил

func _ready():
	$Tower/AnimatedSprite2D.animation = "Idle"


func _process(delta):
	enimies_counter()


func _on_hit_box_body_entered(body): #получение урона башней (разрушение)
	if body == enemy:
		health -= damage_taken


func _on_observation_area_body_entered(body): #вход врага в поле зрения башни
	if body == enemy:
		$Tower/AnimatedSprite2D.animated = "Work"
		observed_enemies += 1


func _on_observation_area_body_exited(body): #выход врага из поля зрения башни
	if body == enemy:
		observed_enemies -= 1
		if observed_enemies == 0:
			$Tower/AnimatedSprite2D.animated = "Idle"


func _on_damage_area_body_entered(body): #вход врага в зону пил
	if body == enemy:
		damaged_enimies += 1 


func _on_damage_area_body_exited(body): #выход врага из зоны пил
	if body == enemy:
		damaged_enimies -= 1

func enimies_counter(): 
	if damaged_enimies != 0:
		$DamageTimer.start(3.0)


func _on_damaged_timer_timeout():
	emit_signal("damage_saw")
	print_debug("Signa 'damage_saw' = '{count}' in emit".format({
		"count": damage_dealt,
	}))
