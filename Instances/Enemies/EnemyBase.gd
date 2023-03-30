class_name EnemyBase

extends CharacterBody2D

@export var enemyBaseResource : EnemyBaseResource
@export var enemyAttacks : EnemyAttack

@onready var player := get_tree().get_nodes_in_group("player")[0] as CharacterBody2D
@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var explosionAnimPlayer := $ExplosionSprite/AnimationPlayerExplosion as AnimationPlayer
@onready var sprite := $AnimatedSprite as AnimatedSprite2D
@onready var collisionShape := $CollisionShape2D as CollisionShape2D
@onready var attackAreaShape := $AttackArea/CollisionShape2D as CollisionShape2D
@onready var enemyAttackTimer := $TimerAttack as Timer
@onready var hitKockBackTimer := $HitKnockBackTimer as Timer

var currentLife := 0
var isAlive = false
var lastBulletImpactDirection := Vector2.ZERO

enum States
{
	IDLE,
	CHASING,
	ESCAPING,
	HIT,
	ATTACK,
	DEATH,
	SPAWNING
}

var currentState := States.SPAWNING

func _init():	
	collision_layer = 0
	
	set_collision_layer_value(4, true) # Own enemy hut box
	
	set_collision_mask_value(6, true) # Watch World	
	set_collision_mask_value(4, true) # Watch another enemies
	
func take_damage(damage, bulletDirection):
	currentLife -= damage
	currentState = States.HIT
	lastBulletImpactDirection = bulletDirection
	hitKockBackTimer.start()
	
func spawned():
	isAlive = true
	currentState = States.IDLE
	enable_disable_enemy(true)
	pass
	
func enable_disable_enemy(active: bool):
	sprite.visible = active
	collisionShape.disabled = !active
	pass
