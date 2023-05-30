extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var flashHit : FlashHit

@export var speed := 50.0

# Combat vars
@export var damage := 1.0
@export var attackDelay := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 8.0

@export var timeIdle := 1.0
@export var timeWalk := 3.0

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var timerIdle := $TimerIdle as Timer
@onready var timerWalk := $TimerWalk as Timer
@onready var rnd := RandomNumberGenerator.new()

@export var orcLowBulletStats : BulletStats

enum States
{
	IDLE,
	CHASING,
	ATTACK,
	DEATH
}

var currentState := States.CHASING
var nextPostion := Vector2.ZERO

func _ready():	
	healthManager.damage.connect(GetHit)
	healthManager.SetLifeBase(lifeBase)
		
	var randTime = rnd.randf_range(0.0, 1.0)
	
	timerIdle.wait_time = timeIdle
	timerIdle.one_shot = true
	timerIdle.autostart = false
	timerIdle.timeout.connect(TimerIdleTimeout)
	
	timerWalk.wait_time = randTime + timeWalk
	timerWalk.one_shot = true
	timerWalk.autostart = false
	timerWalk.timeout.connect(TimerWalkTimeout)
	
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:
			animPlayer.play("Idle")
			
			## Se movimentou até o proximo ponto, quando chegar já ataca
			if timerIdle.is_stopped():
				timerIdle.start()
				ChangeState(States.ATTACK)
			pass
			
		States.CHASING:
			## Contagem de tempo que ficará perseguindo
			if timerWalk.is_stopped():
				timerWalk.start()
			
			if playerTracker.GetDistance() < 5.0:
				timerWalk.stop()
				ChangeState(States.IDLE)
				return
			
			animPlayer.play("Walk")
			moveComponent.Move(self, playerTracker.GetDirection(), delta, 1300, speed)			
			pass
			
		States.ATTACK:
			animPlayer.play("Attack")
			pass

func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished():
	shootManager.FireWithCooldown(playerTracker.GetDirection(), orcLowBulletStats)
	ChangeState(States.IDLE)
	pass
	
func GetHit(attack: Attack):
	flashHit.Flash(sprite.material)
	pass

func TimerIdleTimeout():
	var randTime = rnd.randf_range(0.0, 1.0)
	timerIdle.wait_time = randTime + timeIdle
	ChangeState(States.CHASING)
	
func TimerWalkTimeout():
	var randTime = rnd.randf_range(0.0, 1.0)
	timerWalk.wait_time = randTime + timeWalk
	ChangeState(States.IDLE)
	pass
