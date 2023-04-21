class_name GameState extends Node

var gold: int = 0


func add_gold(amount: int) -> int:
	gold += amount
	return gold


func spend_gold(amount: int) -> int:
	gold -= amount
	return gold
