extends Node2D

@onready var mutant = preload("res://units/enemies/Mutant/mutant.tscn")

func _ready():
	$EnemyPath1.add_enemy(mutant.instantiate())

