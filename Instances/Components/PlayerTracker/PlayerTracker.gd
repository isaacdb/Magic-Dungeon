extends Node2D
class_name PlayerTracker

@onready var playerTrack := get_tree().get_nodes_in_group("player")[0] as CharacterBody2D

func GetDirection():
	return (playerTrack.global_position - self.global_position).normalized()
