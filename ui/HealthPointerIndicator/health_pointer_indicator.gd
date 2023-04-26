class_name HealthPointer extends Control

##Минимальное и максимальное значение поворота стрелки индикатора
var min_angle: int = 0
var max_angle: int = 271

@export var max_hp: int = 100 #в дальнейшем надо будет читать из GameState!
@export var critical_hp_value: int = 20
@export var middle_hp_value: int = 60
@export var duration: float = 0.8


func _ready():
	update_pointer_value(max_hp)


func update_pointer_value(current_hp):
	##Вычисляем значение pointer_value из current_hp
	var pointer_value: int
	pointer_value = max_angle * current_hp / max_hp
	if pointer_value < min_angle:
		pointer_value = 0
	elif pointer_value > max_angle:
		pointer_value = 100	
	##Плавное изменение значения индикатора
	var tween = $PointerNode.create_tween()
	tween.tween_property($PointerNode, "rotation_degrees", pointer_value, duration)
	print_debug("Pointer value is, {value} *".format({"value":pointer_value,}))
	update_animation(current_hp)
	if current_hp <= 0:
		queue_free()

	
func update_animation(current_hp):
	if current_hp < critical_hp_value:
		$AnimationPlayer.play("low_hp")
	elif current_hp > critical_hp_value and current_hp < middle_hp_value:
		$AnimationPlayer.play("middle_hp")	
	else:
		$AnimationPlayer.play("full_hp")
