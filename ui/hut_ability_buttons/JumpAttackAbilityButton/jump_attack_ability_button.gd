extends Control

@export var rollback_time: float = 10.0
@onready var level = get_node("/root/game/level").get_child(0)
@onready var hut = level.get_node("Hut")


func _on_attack_button_pressed():
	if hut != null:
		hut.jump_attack()
		print_debug("Hut jump attack used")
	$AttackButton.disabled = true
	$AbilityTimer.start(rollback_time)


func _on_ability_timer_timeout():
	$AttackButton.disabled = false
