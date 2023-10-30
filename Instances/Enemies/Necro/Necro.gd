extends CharacterBody2D

@export_group("Status")
@export var orcMageBulletStats : BulletStats
@export var lifeBase := 150
@export var speed := 80.0
@export var maxDistanceToWalk := 100
@export var timeIdle := 1.0

@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var deslocate_to_player = $DeslocateToPlayer as DescolateToPlayer
@onready var move_component = $Move as MoveComponent
@onready var player_tracker = $PlayerTracker as PlayerTracker
@onready var health = $Health as Health
@onready var finite_state_machine = %FiniteStateMachine as FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var walk_state = $FiniteStateMachine/WalkState as WalkState
@onready var attack_state = $FiniteStateMachine/AttackState as AttackState
@onready var attack_manager = $AttackManager as AttackManager

func _ready() -> void:
	health.SetLifeBase(lifeBase)

	idle_state.setup_state(timeIdle, sprite);
	walk_state.setup_state(sprite, speed, move_component, self, deslocate_to_player, player_tracker, maxDistanceToWalk)
	attack_state.setup_state(sprite, attack_manager)
	
	finite_state_machine.current_state = idle_state
	if randf() > 0.5: finite_state_machine.current_state = attack_state;
	pass
