# Контейнер с кнопками, расположенными по кругу
# Все дочерние элементы (кнопки) равномерно раскидываются по кругу указанного радиуса
extends Container

# радиус кнопки
var btn_size = 35
# радиус круга кнопок
var button_radius = 90 


func _ready():
	place_buttons()
	
#Распологает кнопки
func place_buttons():
	var buttons = get_children()

	# Останавливает функцию, когда нет доступных кнопок
	if buttons.size() == 0:
		return

	#Величина изменения угла для каждой кнопки
	var angle_offset = (2*PI)/buttons.size() #в градусах

	var angle = 0.785398 #в радианах
	for btn in buttons:
		#рассчет позиции x и y для кнопок под заданным углом
		var x = cos(angle)*button_radius
		var y = sin(angle)*button_radius
		
		#>мы хотим центрировать элемент по кругу.
		#>для этого нам нужно сместить рассчитанные x и y соответственно на половину высоты и ширины
		var corner_pos = Vector2(x, y) - Vector2(btn_size,btn_size)
		btn.set_position(corner_pos)
		
		#Переход к следующему положению
		angle += angle_offset
