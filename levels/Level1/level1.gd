extends Node2D

@onready var test_enemy = preload("res://units/enemies/TestEnemy/test_enemy.tscn")

func _ready():
	$EnemyPath1.add_enemy(test_enemy.instantiate())
