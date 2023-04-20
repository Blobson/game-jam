extends Node2D

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		$CatapultTower.fire(event.position)
