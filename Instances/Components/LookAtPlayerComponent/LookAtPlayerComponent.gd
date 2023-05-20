extends Node2D
class_name LookAtPlayerComponent

@export var playerTracker : PlayerTracker

func _physics_process(delta):
	var character = self.get_parent() as CharacterBody2D
	
	var playerDirection = (playerTracker.playerTrack.global_position - self.global_position).normalized()
	
	if playerDirection.x > 0:
		character.scale.x = 1 * sign(character.scale.y)
	elif playerDirection.x < 0:
		character.scale.x = -1 * sign(character.scale.y)
