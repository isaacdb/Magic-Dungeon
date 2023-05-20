extends Node2D
class_name MoveComponent

@export var walkParticule : CPUParticles2D

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func Move(character: CharacterBody2D, direction: Vector2, delta: float, acceleration: float, speed: float):
	if !isActive:
		return
	
	if direction:
		character.velocity = character.velocity.move_toward(direction * speed, delta * acceleration)
		if walkParticule:
			walkParticule.emitting = true
	else:
		var friction := 20
		character.velocity = character.velocity.lerp(Vector2.ZERO, minf(friction * delta, 1.0))
		if walkParticule:
			walkParticule.emitting = false
	character.move_and_slide()
	pass
