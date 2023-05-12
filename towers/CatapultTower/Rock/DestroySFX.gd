extends AudioStreamPlayer2D


func _on_rock_destroy():
	self.pitch_scale = randf_range(0.8, 1.2)
	self.play()
