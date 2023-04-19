extends Control

@export var rollback_time: float = 20.0
@onready var level = get_node("/root/game/level").get_child(0)
@onready var hut = level.get_node("Hut")


func _on_ability_timer_timeout():
	$RepairButton.disabled = false


func _on_repair_button_pressed():
	if hut != null:
		hut.hut_repair()
		print_debug("Hut repair successful!")
	$RepairButton.disabled = true
	$AbilityTimer.start(rollback_time)
