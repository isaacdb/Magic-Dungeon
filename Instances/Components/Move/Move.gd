extends Node2D
class_name MoveComponent

@export var walkParticule : CPUParticles2D
@export var navAgent : MyNavAgent

var characterToMove : CharacterBody2D

func _ready():
	if navAgent:
		navAgent.velocity_computed.connect(MoveWithAvoidance)
	pass

func Move(character: CharacterBody2D, direction: Vector2, delta: float, acceleration: float, speed: float):	
	characterToMove = character
	if direction:
		character.velocity = character.velocity.move_toward(direction * speed, delta * acceleration)
		if walkParticule:
			walkParticule.emitting = true
	else:
		var friction := 20
		character.velocity = character.velocity.lerp(Vector2.ZERO, minf(friction * delta, 1.0))
		if walkParticule:
			walkParticule.emitting = false
			
	if navAgent:
		navAgent.velocity = character.velocity
	else:
		character.move_and_slide()
	pass

func MoveWithAvoidance(navAgentVelocity: Vector2) -> void:
	if characterToMove:
		characterToMove.velocity = navAgentVelocity
		characterToMove.move_and_slide()
	pass
