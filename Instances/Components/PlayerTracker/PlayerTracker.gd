extends Node2D
class_name PlayerTracker

@onready var playerGroup = get_tree().get_nodes_in_group("player")
var playerTrack : CharacterBody2D

@export var isActive := false

func _ready():
	if playerGroup:
		playerTrack = playerGroup[0] as CharacterBody2D

func SetActive(active: bool):
	isActive = active
	pass

func GetDirection() -> Vector2:
	if !isActive:
		return Vector2.ZERO
	
	return (GetPosition() - self.global_position).normalized()
	
func GetDistance() -> float: 
	return global_position.distance_to(GetPosition())

func GetPosition() -> Vector2:
	if playerTrack and playerTrack != null:
		return playerTrack.global_position
	else:
		return get_global_mouse_position()
