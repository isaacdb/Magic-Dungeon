extends Node2D
class_name DashSkillComponent

@export var dashSpeed := 600
@export var normalSpeed := 10
@export var dashDuration := 0.1
@export var dashCooldown := 3.0
@export var dashStacks := 1

@export var healthComponent : Health

@onready var dashTimerDuration := $DashTimer as Timer
@onready var dashTrail := $Line2D as Line2D

var isDashing = false
var dashDirection := Vector2.ZERO
var characterDash : CharacterBody2D
var acceleration := 800.0
var dashStacksAvailable := 0

func _ready():
	dashStacksAvailable = dashStacks
	
	dashTimerDuration.wait_time = dashDuration
	dashTimerDuration.one_shot = true
	dashTimerDuration.connect("timeout", dashDuration_timeout)
	
func AddDashStack() -> void:
	dashStacksAvailable += 1
	dashStacks += 1
	pass
	
func CanDash() -> bool:
	return !isDashing && dashStacksAvailable > 0
	
func Dash(direction: Vector2, character: CharacterBody2D, speedDefault: float):
	if dashStacksAvailable <= 0:
		return
	
	Global.player_dash.emit()
	dashStacksAvailable -= 1
	characterDash = character
	isDashing = true
	normalSpeed = speedDefault
	dashDirection = direction
	
	if healthComponent:
		healthComponent.SetActive(false)
		
	if dashDirection == Vector2.ZERO:
		dashDirection = Vector2.RIGHT
	
	get_tree().create_timer(dashCooldown).timeout.connect(dashCooldown_timeout)
	dashTimerDuration.start()
	dashTrail.lenght = 50.0
	
	pass

func _physics_process(delta):
	if isDashing:
		characterDash.velocity = characterDash.velocity.move_toward(dashDirection * dashSpeed, acceleration * 20 * delta)	
		
		characterDash.move_and_slide()
	
func dashDuration_timeout():
	isDashing = false
	characterDash.velocity = dashDirection * normalSpeed
	var tween = create_tween()
	tween.tween_property(dashTrail, "lenght", 0.0, 1.0).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	
	if healthComponent:
		healthComponent.SetActive(true)
	pass
	
func dashCooldown_timeout():
	dashStacksAvailable += 1
	pass
