class_name GoldIndicator extends Control

# Время анимации tween
@export var tween_duration: float = 0.8
# Tween для анимации индикатора
var tween_indicator

func _ready():
	#Подсоединяем сигнал change_value
	Game.gold_changed.connect(on_gold_changed)
	#Обновляем индикатор, в начале уровня
	$HBoxContainer/GoldCounter.text = str(Game.gold)


func on_gold_changed(_old: int, new: int):
	if tween_indicator and tween_indicator.is_valid():
		tween_indicator.kill()
	#Создаем tween, задаем параметры анимирования
	tween_indicator = create_tween() \
	.set_trans(Tween.TRANS_QUAD) \
	.set_ease(Tween.EASE_IN_OUT)
	# Запускаем tween, передаем значение в animate_counter
	var from = int($HBoxContainer/GoldCounter.text)
	tween_indicator.tween_method(animate_counter, from, new, tween_duration)


func animate_counter(gold_value: int):
	# Отображаем на индикаторе
	$HBoxContainer/GoldCounter.text = str(gold_value)
