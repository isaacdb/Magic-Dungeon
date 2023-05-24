extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var attackManager : AttackManager
@export var healthManager : Health
@export var shootManager : ShooterComponent

@export var speed := 50.0

# Combat vars
@export var damage := 1.0
@export var attackDelay := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 8.0

@export var timeIdle := 1.0

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var timerIdle := $TimerIdle as Timer
@onready var rnd := RandomNumberGenerator.new()

@onready var orcBullet := preload("res://Instances/Bullet/BulletsEnemies/BulletEnemy1/BulletN.tscn")
@export var orcLowBulletStats : BulletStats

enum States
{
	IDLE,
	CHASING,
	HIT,
	ATTACK,
	DEATH,
	ESCAPE
}

var currentState := States.IDLE
var nextPostion := Vector2.ZERO

func _ready():	
	attackManager.connect("attack_signal", func(): ChangeState(States.ATTACK))
	healthManager.connect("damage", func(): ChangeState(States.HIT))
	
	attackManager.SetAttackDelay(attackDelay)
	healthManager.SetLifeBase(lifeBase)
		
	timerIdle.wait_time = timeIdle
	timerIdle.one_shot = true
	timerIdle.autostart = false
	timerIdle.timeout.connect(TimerIdleTimeout)
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:
			animPlayer.play("Idle")
			if timerIdle.is_stopped():
				timerIdle.start()
			pass
			
		States.CHASING:
			animPlayer.play("Walk")
			var nextPositionDirection = (nextPostion - self.global_position).normalized()
			moveComponent.Move(self, nextPositionDirection, delta, 1300, speed)			
			pass
			
		States.HIT:
			animPlayer.play("Hit")
			pass
			
		States.ATTACK:
			animPlayer.play("Attack")
			pass

func SetNextPosition():
	nextPostion = playerTracker.playerTrack.global_position

func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished():
	var playerDirection = playerTracker.GetDirection()
	shootManager.FireWithCooldown(playerDirection, orcBullet, orcLowBulletStats)
	ChangeState(States.IDLE)
	pass
	
func HitFinished():
	ChangeState(States.IDLE)
	pass	

func TimerIdleTimeout():
	var randTime = rnd.randf_range(0.0, 1.0)
	timerIdle.wait_time = randTime + timeIdle
	SetNextPosition()
	ChangeState(States.CHASING)
