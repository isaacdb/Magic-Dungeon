extends CharacterBody2D
class_name Mage1

@export var moveComponent : MoveComponent
@export var healthManager : Health
@export var flashHit : FlashHit
@export var shootManager : ShooterComponent
@export var bulletStats : BulletStats
@export var weapon : Weapon
@export var playerInput : PlayerInputManager;

@export var acceleration := 1400.0
@export var speed := 150.0
@export var lifeBase := 10.0
@export var fireRate := 1.0

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var dashSkill := $DashSkill as DashSkillComponent
@onready var timerIFrame := $TimerIFrame as Timer

var isAlive = true
var durationIFrame := 0.6

func _ready() -> void:
	animationPlayer.play("Idle")
	
	healthManager.damage.connect(GetHited)	
	healthManager.SetLifeBase(lifeBase)
	
	Global.set_player_max_life.emit(lifeBase)
	
	shootManager.UpdateFireRate(fireRate)
	
	timerIFrame.wait_time = durationIFrame
	timerIFrame.one_shot = true
	timerIFrame.autostart = false
	timerIFrame.timeout.connect(EndIFrame)
	pass

func _process(delta) -> void:
	if Input.is_action_pressed("fire") && !Global.mouseOverGUI:
		Fire();
	pass

func is_ui_clicked():
	var clickable_collider = get_clickable_collider()
	
	if clickable_collider:
		return clickable_collider.has_group("UI")
	
	print(clickable_collider)
	return false

func get_clickable_collider():
	var mouse_pos = get_viewport().get_mouse_position()
	var space_state = get_world_2d().direct_space_state
	var param = PhysicsPointQueryParameters2D.new()
	param.position = mouse_pos;
	var result = space_state.intersect_point(param)
	
	for i in result:
		print(i)
	
	if result:
		return result.collider
	else:
		return null

func _physics_process(delta) -> void:
	if !isAlive:
		return
	
	var moveInput = playerInput.GetAxisInput()
	
	if Input.is_action_just_pressed("dash") and dashSkill.canDash:
		dashSkill.Dash(moveInput, self, speed)
	else:
		moveComponent.Move(self, moveInput, delta, acceleration, speed)
		
	sprite2D.flip_h = (get_global_mouse_position() - position).x < 0
	pass	

func GetHited(attack: Attack) -> void:
	Global.emit_signal("screen_shake", 10.0, .3, 1)
	Global.player_hited.emit()
	flashHit.Flash(sprite2D.material)
	StartIFrame()
	pass	

func ChangeAnim(anim: String) -> void:
	animationPlayer.play(anim)
	
func StartIFrame() -> void:
	healthManager.SetActive(false)
	timerIFrame.start()
	
# Chamado no timeout do timerIFrame
func EndIFrame() -> void:
	healthManager.SetActive(true)

func UpdateFireRate(newFireRate: float):
	shootManager.UpdateFireRate(newFireRate)
	pass

func Fire() -> void:
	var direction = playerInput.GetMouseDirection(shootManager.global_position)
	var shoot = shootManager.FireWithCooldown(direction, bulletStats)
	if shoot:
		Global.emit_signal("screen_shake", 1, .1, 1)
		weapon.PlayAnimFire();
