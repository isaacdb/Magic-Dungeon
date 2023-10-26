extends CharacterBody2D

@export var bullet_stats : BulletStats

@export var speed := 80.0
@export var life_base := 5.0
@export var time_walking := 6.0
@export var time_dle := 3.0
@export var delay_fire := 0.5

@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var attack_manager = $AttackManager as AttackManager
@onready var move_component = $Move as MoveComponent
@onready var player_tracker = $PlayerTracker as PlayerTracker
@onready var health_manager = $Health as Health
@onready var group_flip = $GroupFlip as Node2D

@onready var finite_state_machine = %FiniteStateMachine as FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState as IdleState
@onready var walk_and_fire_state = $FiniteStateMachine/WalkAndFireState as WalkAndFireState

func _ready() -> void:
	health_manager.SetLifeBase(life_base)

	idle_state.setup_state(time_dle, sprite);
	walk_and_fire_state.setup_state(sprite, speed, move_component, self, player_tracker, time_walking, delay_fire, attack_manager, group_flip)
	
	finite_state_machine.current_state = idle_state
	if randf() > 0.5: finite_state_machine.current_state = walk_and_fire_state;
	pass
