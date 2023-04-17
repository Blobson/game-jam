extends Camera2D

var width = ProjectSettings.get_setting('display/window/size/width')
var height = ProjectSettings.get_setting('display/window/size/height')
@onready var camera = $Camera2D

func _on_resized():
	if not camera: return
	var current_width = self.rect_size.x
	var current_height = self.rect_size.y
	var delta_width = max(0, current_width - width)
	var delta_height = max(0, current_height - height)
	camera.offset = Vector2(-delta_width / 2, -delta_height / 2)
