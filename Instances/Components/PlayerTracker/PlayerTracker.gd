extends Node2D
class_name PlayerTracker

@onready var playerGroup = get_tree().get_nodes_in_group("player")
var playerTrack : CharacterBody2D

func _ready():
	if playerGroup:
		playerTrack = playerGroup[0] as CharacterBody2D

func GetDirection() -> Vector2:
	return (GetPosition() - self.global_position).normalized()
	
func GetDistance() -> float: 
	return global_position.distance_to(GetPosition())

func GetPosition() -> Vector2:
	if playerTrack and playerTrack != null:
		return playerTrack.global_position
	else:
		return get_global_mouse_position()
