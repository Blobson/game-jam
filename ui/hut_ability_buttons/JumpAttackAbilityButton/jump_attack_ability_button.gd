extends Control

@export var rollback_time: float = 10.0
@onready var hut = Game.getHut()


func _on_attack_button_pressed():
	if hut != null:
		hut.jump_attack()
		print_debug("Hut jump attack used")
	$AttackButton.disabled = true
	$AbilityTimer.start(rollback_time)


func _on_ability_timer_timeout():
	$AttackButton.disabled = false
