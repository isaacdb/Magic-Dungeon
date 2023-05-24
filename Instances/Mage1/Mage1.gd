extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var healthManager : Health
@export var flashHit : FlashHit
@export var wand : Wand

@export var acceleration := 800.0
@export var speed := 200.0
@export var lifeBase := 10.0
@export var fireRate := 1.0

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var dashSkill := $DashSkill as DashSkillComponent
@onready var timerIFrame := $TimerIFrame as Timer

var isAlive = true
var durationIFrame := 0.6

func _ready():
	animationPlayer.play("Idle")
	healthManager.damage.connect(GetHited)
	
	healthManager.SetLifeBase(lifeBase)
	Global.set_player_max_life.emit(lifeBase)
	Global.update_player_life.emit(lifeBase)
	wand.UpdateFireRate(fireRate)
	
	timerIFrame.wait_time = durationIFrame
	timerIFrame.one_shot = true
	timerIFrame.autostart = false
	timerIFrame.timeout.connect(EndIFrame)
	pass

func _physics_process(delta):
	if !isAlive:
		return
	
	var input = getAxisInput()
	
	if Input.is_action_just_pressed("dash") and dashSkill.canDash:
		dashSkill.Dash(input, self, speed)
	else:
		moveComponent.Move(self, input, delta, acceleration, speed)
		
	sprite2D.flip_h = (get_global_mouse_position() - position).x < 0
	pass	

func GetHited():
	Global.emit_signal("screen_shake", 10.0, .3, 1)
	Global.player_hited.emit()
	flashHit.Flash(sprite2D.material)
	StartIFrame()	
	ChangeFireRate()	
	pass
	
func ChangeFireRate():
	var lifePercent = (healthManager.currentHealth * 100) / healthManager.lifeBase
	if lifePercent > 80:
		wand.UpdateFireRate(fireRate)
	elif lifePercent >= 50:
		wand.UpdateFireRate(fireRate / 2)
	elif lifePercent >= 30:
		wand.UpdateFireRate(fireRate / 4)

func ChangeAnim(anim: String):
	animationPlayer.play(anim)
	
func StartIFrame():
	healthManager.SetActive(false)
	timerIFrame.start()
	
# Chamado no timeout do timerIFrame
func EndIFrame():
	healthManager.SetActive(true)

func getAxisInput() -> Vector2:
	var directionH = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionV = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	
	return Vector2 (directionH, directionV).normalized()
