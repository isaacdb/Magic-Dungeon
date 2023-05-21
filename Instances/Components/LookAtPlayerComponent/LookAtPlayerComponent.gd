extends Node2D
class_name LookAtPlayerComponent

@export var playerTracker : PlayerTracker

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func _physics_process(delta):
	if !isActive:
		return
	
	var nodeToFlip = self.get_parent() as Node2D
	
	var playerDirection = (playerTracker.playerTrack.global_position - self.global_position).normalized()
	
	if playerDirection.x > 0:
		nodeToFlip.scale.x = -1 * sign(nodeToFlip.scale.y)
	elif playerDirection.x < 0:
		nodeToFlip.scale.x = 1 * sign(nodeToFlip.scale.y)
