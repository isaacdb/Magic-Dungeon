extends CharacterBody2D

@export var speed = 200
@export var acceleration = 800
@export var friction = 20
@export var spriteTexture : CompressedTexture2D
@export var lifeBase := 10

@export var dashSpeed := 600
@export var dashDuration := 0.1
@export var dashCooldown := 1.0

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var dashTimerDuration := $DashTimer as Timer
@onready var dashTimerCD := $DashTimerCooldown as Timer
@onready var dashParticule := $DashParticle as CPUParticles2D
@onready var walkParticule := $WalkParticle as CPUParticles2D

var currentLife := lifeBase
var canDash = true
var isDashing = false
var dashDirection := Vector2.ZERO
var isAlive = true

func _ready():
	animationPlayer.play("Idle")
	dashTimerDuration.wait_time = dashDuration
	dashTimerDuration.one_shot = true
	dashTimerDuration.connect("timeout", dashDuration_timeout)
	dashTimerCD.wait_time = dashCooldown
	dashTimerCD.one_shot = true
	dashTimerCD.connect("timeout", dashCooldown_timeout)
	pass 

func _physics_process(delta):
	if !isAlive:
		velocity = velocity.lerp(Vector2.ZERO, minf(friction * delta, 1.0))
		return
	
	if Input.is_action_just_pressed("dash") and canDash:
		dash()
		
	_move(delta)
	pass
		
	
func _move(delta):	
	var moveDirection = getAxisInput()
	
	if isDashing:
		moveDirection = dashDirection
		velocity = velocity.move_toward(moveDirection * dashSpeed, acceleration * 20 * delta)
	else:		
		walkParticule.emitting = moveDirection != Vector2.ZERO
		if moveDirection:
			velocity = velocity.move_toward(moveDirection * speed, acceleration * delta)
		else:
			velocity = velocity.lerp(Vector2.ZERO, minf(friction * delta, 1.0))
			
	move_and_slide()
	
	sprite2D.flip_h = (get_global_mouse_position() - position).x < 0
	sprite2D.rotation_degrees = moveDirection.x * 5
	pass

func getAxisInput() -> Vector2:
	var directionH = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionV = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	
	return Vector2 (directionH, directionV).normalized()
	pass

func dash():
	isDashing = true
	canDash = false
	
	dashDirection = getAxisInput()
	if dashDirection == Vector2.ZERO:
		dashDirection = Vector2.RIGHT
	
	dashTimerDuration.start()
	dashParticule.emitting = true
	walkParticule.emitting = false
	pass	
	
func take_damage(damage):
	if !isAlive:
		return
		
	currentLife -= damage
	animationPlayer.play("Hit")	
	
	if currentLife <= 0:
		Global.emit_signal("player_dead")
		isAlive = false
	pass
	
func dashDuration_timeout():
	dashTimerCD.start()
	isDashing = false
	velocity = dashDirection * speed
	dashParticule.emitting = false
	walkParticule.emitting = true
	pass
	
func dashCooldown_timeout():
	canDash = true
	pass
