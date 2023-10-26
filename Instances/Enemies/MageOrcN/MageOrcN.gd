extends CharacterBody2D

@export_group("Components")
@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health

@export_group("Status")
@export var orcMageBulletStats : BulletStats
@export var lifeBase := 5
@export var speed := 80.0
@export var maxDistanceToWalk := 100
@export var timeIdle := 1.0

@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var deslocateToPlayer = $DeslocateToPlayer as DescolateToPlayer
@onready var rnd := RandomNumberGenerator.new()

@onready var finite_state_machine = %FiniteStateMachine as FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var walk_state = $FiniteStateMachine/WalkState as WalkState
@onready var attack_state = $FiniteStateMachine/AttackState as AttackState
@onready var attack_manager = $AttackManager as AttackManager


func _ready() -> void:
	healthManager.SetLifeBase(lifeBase)

	idle_state.setup_state(timeIdle, sprite);
	walk_state.setup_state(sprite, speed, moveComponent, self, deslocateToPlayer, playerTracker, maxDistanceToWalk)
	attack_state.setup_state(sprite, attack_manager)
	
	finite_state_machine.current_state = idle_state
	if randf() > 0.5: finite_state_machine.current_state = attack_state;
	pass




