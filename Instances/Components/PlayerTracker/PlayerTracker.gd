extends Node2D
class_name PlayerTracker

@onready var playerTrack := get_tree().get_nodes_in_group("player")[0] as CharacterBody2D

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func GetDirection():
	if !isActive:
		return Vector2.ZERO
	
	return (playerTrack.global_position - self.global_position).normalized()
