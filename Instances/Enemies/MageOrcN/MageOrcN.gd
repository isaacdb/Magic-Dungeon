extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var flashHit : FlashHit

@export var orcMageBulletStats : BulletStats

@export var lifeBase := 5
@export var speed := 80.0

@export var timeIdle := 1.0
@onready var timerIdle := $TimerIdle as Timer
@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D

@onready var rnd := RandomNumberGenerator.new()

enum States
{
	IDLE,
	CHASING,
	ATTACK,
	DEATH
}

var currentState := States.IDLE
var nextPostion := Vector2.ZERO

func _ready():	
	healthManager.damage.connect(GetHit)	
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
			
			## Se movimentou até o proximo ponto, quando chegar já ataca
			if timerIdle.is_stopped():
				timerIdle.start()
				ChangeState(States.ATTACK)
			pass
			
		States.CHASING:
			if global_position.distance_to(nextPostion) < 2.0:
				ChangeState(States.IDLE)
				return
				
			animPlayer.play("Walk")
			var nextPositionDirection = (nextPostion - self.global_position).normalized()
			moveComponent.Move(self, nextPositionDirection, delta, 1300, speed)
			pass

		States.ATTACK:
			animPlayer.play("Attack")
			pass
			
func GetHit():
	flashHit.Flash(sprite.material)
	pass

func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished():
	var playerDirection = playerTracker.GetDirection()
	shootManager.JustFire(playerDirection, orcMageBulletStats)
	ChangeState(States.IDLE)
	pass
	
func SetNextPosition():
	nextPostion = playerTracker.playerTrack.global_position	
	
func TimerIdleTimeout():
	var randTime = rnd.randf_range(0.0, 1.0)
	timerIdle.wait_time = randTime + timeIdle
	SetNextPosition()
	ChangeState(States.CHASING)
