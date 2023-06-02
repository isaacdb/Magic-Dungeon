extends Line2D

func _process(delta):
	clear_points()
	add_point(Vector2.ZERO)	
	add_point(get_global_mouse_position() - self.global_position)
	pass
