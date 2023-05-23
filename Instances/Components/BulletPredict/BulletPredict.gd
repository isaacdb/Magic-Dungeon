extends Line2D

@export var lenght := 50

var point := Vector2.ZERO

func _process(delta):	
	var mouseDirection = (get_global_mouse_position() - self.global_position).normalized()	
	
	clear_points()
	add_point(Vector2.ZERO)	
	add_point(get_global_mouse_position() - self.global_position)
	pass
