extends Node2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		$ElectricTower.fire(event.position)
