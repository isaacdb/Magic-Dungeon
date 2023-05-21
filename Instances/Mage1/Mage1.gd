extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var healthManager : Health

@export var acceleration := 800.0
@export var speed := 200.0
@export var lifeBase := 10.0

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var dashSkill := $DashSkill as DashSkillComponent

var isAlive = true

func _ready():
	animationPlayer.play("Idle")
	healthManager.connect("damage",func(): GetHited())
	
	healthManager.SetLifeBase(lifeBase)
	Global.set_player_max_life.emit(lifeBase)
	Global.update_player_life.emit(lifeBase)
	print("mage ready")
		
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
	ChangeAnim("Hit")
	StartIFrame()
	Global.update_player_life.emit(healthManager.currentHealth)
	pass

func EndHitFrame():
	ChangeAnim("Idle")
	EndIFrame()
	pass

func ChangeAnim(anim: String):
	animationPlayer.play(anim)
	
func StartIFrame():
	healthManager.SetActive(false)
	
func EndIFrame():
	healthManager.SetActive(true)

func getAxisInput() -> Vector2:
	var directionH = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionV = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	
	return Vector2 (directionH, directionV).normalized()
