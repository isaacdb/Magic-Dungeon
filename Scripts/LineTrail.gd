extends Line2D
class_name LineTrail

@export var lenght := 50
@export var targetToFollow : Node2D

var point := Vector2.ZERO

func _ready():
	clear_points();
	if !targetToFollow:
		targetToFollow = get_parent()

func _process(delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	
	point = targetToFollow.global_position
	add_point(point)
	
	while get_point_count() > lenght:
		remove_point(0)
	
	pass
