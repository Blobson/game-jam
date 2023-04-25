class_name HealthPointer extends Control

##Минимальное и максимальное значение поворота стрелки индикатора
@onready var min_value: int = 0
@onready var max_value: int = 271
@onready var pointer_value: float

@onready var max_hp: int = 100 #в дальнейшем надо читать из GameState
var current_hp = 6 #в дальнейшем надо читать из GameState
## Значение после которого возрастает амплитуда анимации стрелки
@export var critical_hp_value: int = 10

func _ready():
	update_pointer_value()


func update_pointer_value():
	pointer_value = max_value * current_hp / max_hp
	if pointer_value < min_value:
		pointer_value = 0
	elif pointer_value > max_value:
		pointer_value = 100	
	$PointerNode.rotation_degrees = pointer_value
	update_animation()


func update_animation():
	if current_hp < critical_hp_value:
		$AnimationPlayer.play("low")
	else:
		$AnimationPlayer.play("idle")
