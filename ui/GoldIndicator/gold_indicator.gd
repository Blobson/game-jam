class_name GoldIndicator extends Control

#Время анимации tween
@onready var tween_duration: float = 0.8


func _ready():
	#Подсоединяем сигнал change_value
	var game = get_node("/root/Game")
	Game.gold_changed.connect(change_value)


func change_value(old, new):
	#создаем tween, задаем параметры 
	var tween_indicator = create_tween()
	tween_indicator.set_trans(Tween.TRANS_QUAD)
	tween_indicator.set_ease(Tween.EASE_IN_OUT)
	#Запускаем tween, передаем значение в counert_interpolate
	tween_indicator.tween_method(counter_interpolate, old, new, tween_duration)


func counter_interpolate(gold_value):
	#Округляем значение
	var round_gold_value = round(gold_value)
	#Отображаем на индикаторе
	$HBoxContainer/GoldCounter.text = str(round_gold_value)
