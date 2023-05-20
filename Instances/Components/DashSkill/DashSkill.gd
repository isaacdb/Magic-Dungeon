extends Node2D
class_name DashSkillComponent

@export var dashSpeed := 600
@export var normalSpeed := 10
@export var dashDuration := 0.1
@export var dashCooldown := 1.0

@onready var dashTimerDuration := $DashTimer as Timer
@onready var dashTimerCD := $DashTimerCooldown as Timer
@onready var dashParticule := $DashParticle as CPUParticles2D

var canDash = true
var isDashing = false
var dashDirection := Vector2.ZERO
var characterDash : CharacterBody2D
var acceleration := 800.0
var isActive := false

	
func _ready():
	dashTimerDuration.wait_time = dashDuration
	dashTimerDuration.one_shot = true
	dashTimerDuration.connect("timeout", dashDuration_timeout)
	dashTimerCD.wait_time = dashCooldown
	dashTimerCD.one_shot = true
	dashTimerCD.connect("timeout", dashCooldown_timeout)

func SetActive(active: bool):
	isActive = active
	pass
	
func Dash(direction: Vector2, character: CharacterBody2D, speedDefault: float):
	if !canDash or !isActive:
		return
	
	characterDash = character
	isDashing = true
	canDash = false
	normalSpeed = speedDefault
	dashDirection = direction
		
	if dashDirection == Vector2.ZERO:
		dashDirection = Vector2.RIGHT
	
	dashTimerDuration.start()
	dashParticule.emitting = true
	pass	

func _physics_process(delta):
	if isDashing and isActive:
		characterDash.velocity = characterDash.velocity.move_toward(dashDirection * dashSpeed, acceleration * 20 * delta)	
		
		characterDash.move_and_slide()		
	
	
func dashDuration_timeout():
	dashTimerCD.start()
	isDashing = false
	characterDash.velocity = dashDirection * normalSpeed
	dashParticule.emitting = false
	pass
	
func dashCooldown_timeout():
	canDash = true
	pass
