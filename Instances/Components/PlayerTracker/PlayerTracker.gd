extends Node2D
class_name PlayerTracker

@onready var playerTrack := get_tree().get_nodes_in_group("player")[0] as CharacterBody2D

@export var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func GetDirection() -> Vector2:
	if !isActive:
		return Vector2.ZERO
	
	return (playerTrack.global_position - self.global_position).normalized()
	
func GetDistance() -> float: 
	return global_position.distance_to(playerTrack.global_position)
