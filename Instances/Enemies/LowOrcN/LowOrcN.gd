extends CharacterBody2D

@export_group("Components")
@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var attackManager : AttackManager

@export_group("Status")
@export var orcLowBulletStats : BulletStats
@export var timeIdle := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 8.0
@export var speed := 50.0
@export var maxDistanceToWalk := 150

@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var deslocateToPlayer = $DeslocateToPlayer as DescolateToPlayer

@onready var finite_state_machine = %FiniteStateMachine as FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var walk_state = $FiniteStateMachine/WalkState as WalkState
@onready var attack_state = $FiniteStateMachine/AttackState as AttackState

func _ready() -> void:
	healthManager.SetLifeBase(lifeBase)

	idle_state.setup_state(timeIdle, sprite);
	walk_state.setup_state(sprite, speed, moveComponent, self, deslocateToPlayer, playerTracker, maxDistanceToWalk)
	attack_state.setup_state(sprite, attackManager)

	finite_state_machine.current_state = idle_state
	if randf() > 0.5: finite_state_machine.current_state = attack_state;
	pass
