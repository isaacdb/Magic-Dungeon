extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var attackManager : AttackManager
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var speed := 80.0

@export var orcMageBulletStats : BulletStats

@export var fireRate := 2.5
@export var lifeBase := 5

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var orcBullet := preload("res://Instances/Bullet/BulletsEnemies/BulletEnemy1/BulletN.tscn")

enum States
{
	IDLE,
	CHASING,
	HIT,
	ATTACK,
	DEATH
}

var currentState := States.IDLE

func _ready():
	attackManager.connect("attack_signal", func(): ChangeState(States.ATTACK))
	healthManager.connect("damage", func(): ChangeState(States.HIT))
	
	attackManager.SetAttackDelay(fireRate)
	healthManager.SetLifeBase(lifeBase)
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:
			animPlayer.play("Idle")
			if !attackManager.playerInRange:
					ChangeState(States.CHASING)
			pass
			
		States.CHASING:
			animPlayer.play("Walk")
			var playerDirection = playerTracker.GetDirection()
			moveComponent.Move(self, playerDirection, delta, 1300, speed)
			
			if attackManager.playerInRange:
				ChangeState(States.IDLE)
			pass
			
		States.HIT:
			animPlayer.play("Hit")
			pass
			
		States.ATTACK:
			animPlayer.play("Attack")
			pass
				

func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished():
	var playerDirection = playerTracker.GetDirection()
	shootManager.Fire(playerDirection, orcBullet, orcMageBulletStats)
	ChangeState(States.IDLE)
	pass
	
func HitFinished():
	ChangeState(States.IDLE)
	pass	
