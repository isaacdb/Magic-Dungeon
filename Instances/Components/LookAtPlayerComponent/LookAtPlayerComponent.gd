extends Node2D
class_name LookAtPlayerComponent

@export var playerTracker : PlayerTracker

func _physics_process(delta):	
	var nodeToFlip = self.get_parent() as Node2D
	
	var playerDirection = playerTracker.GetDirection()
	
	if playerDirection.x > 0:
		nodeToFlip.scale.x = -1 * sign(nodeToFlip.scale.y)
	elif playerDirection.x < 0:
		nodeToFlip.scale.x = 1 * sign(nodeToFlip.scale.y)
