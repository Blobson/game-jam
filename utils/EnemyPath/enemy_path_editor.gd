@tool class_name EnemyPathEditor extends Path2D

## Ширина пути
@export var width: int = 200 :
	set(value):
		if width != value:
			width = value
			queue_redraw()


func _draw_path():
	var points_up = PackedVector2Array()
	var points_down = PackedVector2Array()
	var half_width = width / 2.0
	
	var length = curve.get_baked_length()
	var offset = 0
	while offset < length:
		# получаем точку на пути с направлением движения
		var tx = curve.sample_baked_with_rotation(offset)
		var pos = tx.get_origin()
		var dir = Vector2.UP.rotated(tx.get_rotation())
		
		# вычисляем нормаль к направлению
		var normal = dir.orthogonal().normalized()
		
		# откладывам точку сверху и снизу по нормали от pos
		var up = pos + normal * half_width
		var down = pos - normal * half_width
		
		# проверяем не попали ли точки внутрь пути и сохраняем их
		if curve.get_closest_point(up).distance_to(up) >= half_width - 1:
			points_up.append(up)
		if curve.get_closest_point(down).distance_to(down) >= half_width - 1:
			points_down.append(down)
		
		# продвигаемся дальше по пути на bake_interval (обычно 5 пикселей)
		offset += curve.bake_interval
		
	if points_up.size() > 2:
		draw_polyline(points_up, Color.DARK_OLIVE_GREEN)
		
	if points_down.size() > 2:
		draw_polyline(points_down, Color.DARK_OLIVE_GREEN)


func _draw():
#	if Engine.is_editor_hint():
	_draw_path()
