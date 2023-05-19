extends Node2D
class_name MoveComponent

@export var speed := 0.0

func Move(character: CharacterBody2D, direction: Vector2, delta: float):
	character.velocity = character.velocity.move_toward(direction * speed, delta * 1300)
	character.move_and_slide()
	pass
