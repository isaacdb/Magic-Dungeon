extends Node2D
class_name BulletN

@export var bulletStats : BulletStats

@export var moveDirection := Vector2.ZERO

@export var enemyColor : Color
@export var playerColor : Color

@onready var timer := $Timer as Timer
@onready var sprite := $Sprite2D as AnimatedSprite2D
@onready var lineTrail := $Line2D as Line2D
@onready var hitBox := $HitBox as HitBoxComponent
@onready var wallDetect := $WallDetect as Area2D
@onready var impactParticle := $ImpactPaticle as CPUParticles2D

var velocity := Vector2.ZERO
var speed := 0.0
var isRunning := true

func _ready():	
	hitBox.monitoring = true
	hitBox.monitorable = true # Have to be true, just bc a bug, its required for collision with tileemap
	
	timer.one_shot = true
	hitBox.connect("attack_enter", Destroy)
	hitBox.SetActive(true)
	
	wallDetect.connect("body_entered", WorldCollision)
	pass

func UpdateStats(bulletStats: BulletStats):
	match bulletStats.origin:
		"None":
			print("Bullet origin is MISSING!!")
		"Player":
			hitBox.set_collision_mask_value(4, true) #Collision with enemy hurtBox
			sprite.modulate = playerColor
			lineTrail.modulate = playerColor
			impactParticle.modulate = playerColor
		"Enemy":
			hitBox.set_collision_mask_value(2, true) #Collision with player hurtBox
			sprite.modulate = enemyColor
			lineTrail.modulate = enemyColor
			impactParticle.modulate = enemyColor
			
	speed = bulletStats.speed
	hitBox.damage = bulletStats.damage
	hitBox.knockBackForce = bulletStats.knockBackForce	

func _physics_process(delta):
	if isRunning:
		velocity = speed * moveDirection * delta	
		translate(velocity)	
	pass
	
func Destroy():
	isRunning = false
	#collisionShape.set_deferred("Disabled", true)
	hitBox.queue_free()
	sprite.queue_free()
	
	impactParticle.emitting = true
	timer.wait_time = 1.5
	timer.start()
	
	await timer.timeout
	
	self.queue_free()	
	pass

func WorldCollision(body):
	SetParticleToWallCollision()	
	Destroy()
	pass

func SetParticleToWallCollision():
	impactParticle.rotate(deg_to_rad(180))
	impactParticle.spread = 180
	impactParticle.initial_velocity_min = 100
	impactParticle.initial_velocity_min = 150	
	pass

