extends Enemy


func _ready():
	$AnimationPlayer.play("walk")
	super._ready()

func _move_to(target_transform):
# Направление по-умолчанию - наверх
# Если движемся налево, то разворачиваем направление модельки 
# Если направо - то не разворачиваем
	if target_transform.get_rotation()>0:
		$Sprite2D.set("flip_h", false)
	elif target_transform.get_rotation()<0:
		$Sprite2D.set("flip_h", true)
	super._move_to(target_transform)
