extends CharacterBody2D
class_name Mage1

@export var moveComponent : MoveComponent
@export var healthManager : Health
@export var flashHit : FlashHit
@export var weapon : Weapon
@export var playerInput : PlayerInputManager;

@export var acceleration := 1400.0
@export var speed := 150.0
@export var lifeBase := 10.0

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var dashSkill := $DashSkill as DashSkillComponent
@onready var timerIFrame := $TimerIFrame as Timer
@onready var impact_paticle = $ImpactPaticle as CPUParticles2D

var isAlive = true
var durationIFrame := 2.0

func _ready() -> void:
	animationPlayer.play("Idle")
	
	flashHit.end_flash_damage.connect(FlashingIFrame);
	
	healthManager.damage.connect(GetHited)	
	healthManager.SetLifeBase(lifeBase)
	healthManager.SetCurrentLife(StatsManager.currentLife);
	
	SetupIFrameTimer(durationIFrame)
	pass

func _process(delta) -> void:
	if playerInput.PressFire() && !Global.mouseOverGUI:
		Fire();
	pass

func SetupIFrameTimer(duration: float) -> void:
	durationIFrame = duration
	if timerIFrame:
		timerIFrame.wait_time = duration
		timerIFrame.one_shot = true
		timerIFrame.autostart = false
		if not timerIFrame.timeout.is_connected(EndIFrame):
			timerIFrame.timeout.connect(EndIFrame)
	pass

func _physics_process(delta) -> void:
	if !isAlive:
		return
	
	var moveInput = playerInput.GetAxisInput()
	
	if playerInput.PressDash() and dashSkill.CanDash():
		dashSkill.Dash(moveInput, self, speed)
	else:
		moveComponent.Move(self, moveInput, delta, acceleration, speed)
		
	sprite2D.flip_h = (get_global_mouse_position() - position).x < 0
	pass

func GetHited(attack: Attack) -> void:
	Global.emit_signal("screen_shake", 10.0, .3, 1)
	Global.player_hited.emit()
	StartIFrame()
	
	if attack.damage <= 0:
		return
	
	impact_paticle.emitting = true
	Global.player_remove_life.emit()
	pass	

func ChangeAnim(anim: String) -> void:
	animationPlayer.play(anim)
	
func StartIFrame() -> void:
	healthManager.SetActive(false);
	timerIFrame.start();
	
func FlashingIFrame() -> void:
	flashHit.IFrameFlahsing(timerIFrame.time_left);
	pass
	
# Chamado no timeout do timerIFrame
func EndIFrame() -> void:
	healthManager.SetActive(true)

func Fire() -> void:
	var direction = playerInput.GetMouseDirection(weapon.GetSpawnPoint())
	weapon.Fire(direction);
