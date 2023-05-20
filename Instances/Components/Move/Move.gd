extends Node2D
class_name MoveComponent

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func Move(character: CharacterBody2D, direction: Vector2, delta: float, acceleration: float, speed: float):
	if !isActive:
		return
	
	if direction:
		character.velocity = character.velocity.move_toward(direction * speed, delta * acceleration)
	else:
		var friction := 20
		character.velocity = character.velocity.lerp(Vector2.ZERO, minf(friction * delta, 1.0))
	character.move_and_slide()
	pass
