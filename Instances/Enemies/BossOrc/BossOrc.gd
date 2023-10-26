extends CharacterBody2D

@export_group("Components")
@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var flashHit : FlashHit
@export var attackManager : AttackManager

@export_group("Rage mode")
@export var audioRage : AudioStream

@export_group("Combat vars")
@export var speed := 50.0
@export var damage := 1.0
@export var attackDelay := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 100.0
@export var timeIdle := 3.0
@export var timeWalk := 3.0


@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var rnd := RandomNumberGenerator.new()
@onready var audioPlayer := $AudioStreamPlayer2D as AudioStreamPlayer2D

var isInRage := false

@onready var finite_state_machine = %FiniteStateMachine as FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var attack_state = $FiniteStateMachine/AttackState as AttackState
@onready var chase_player_state = $FiniteStateMachine/ChasePlayerState as ChasePlayerState

func _ready():
	healthManager.damage.connect(GetHit)
	healthManager.SetLifeBase(lifeBase)
	healthManager.lifeBar.UpdateHealthBar(lifeBase)
	
	set_rage_mode_items(false);
	
	idle_state.setup_state(timeIdle, sprite);
	chase_player_state.setup_state(sprite, speed, moveComponent, self, playerTracker, timeWalk)
	attack_state.setup_state(sprite, attackManager)

	finite_state_machine.current_state = idle_state
	pass

func GetHit(attack: Attack):
	if healthManager.currentHealth < lifeBase/2:
		SetRageMode()
		
	if healthManager.currentHealth <= 0:
		Global.boss_killed.emit()
	pass
	
func set_rage_mode_items(active: bool) -> void:
	for i in get_tree().get_nodes_in_group("rage_mode"):
		if i is CanvasItem:
			i.visible = active
	pass
	
func SetRageMode():
	if isInRage:
		return
	
	isInRage = true
	
	set_rage_mode_items(true);
	
	timeIdle = 1.0
	idle_state.time_idle = timeIdle;
	
	speed = 130.0
	chase_player_state.speed = speed;
	
	audioPlayer.stream = audioRage
	audioPlayer.play()
	pass
