class_name GoldIndicator extends Control

@onready var gold_indicator_value: int

func _ready():
	gold_indicator_value = $"/root/Game".gold
	
func change_value(old, new):
	$HBoxContainer/GoldValue.text = str(new)
