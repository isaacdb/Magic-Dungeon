extends Node2D
class_name DescolateToPlayer

@onready var raycast = $RayCast2D as RayCast2D

func _ready():
	pass

func GetNextPosition(direction: Vector2, distanceWalk: float, angle: float) -> Vector2:
	var locatePlayerTrys := 10
	for i in locatePlayerTrys:
		var randAngle = randf_range(-angle, angle);
		var newDirection = direction.rotated(deg_to_rad(randAngle))
		var finalPosition = newDirection * distanceWalk;
		
		raycast.target_position = finalPosition
		if not raycast.is_colliding():
			return finalPosition
			
	raycast.target_position = Vector2.ZERO
	return Vector2.ZERO
