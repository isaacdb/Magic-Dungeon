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

var _lastPositionCheckStuck : Vector2
var _timeCheckIfStuck := 1.0
var _currentTimeCheckStuck := 0.0


func _ready() -> void:
	healthManager.damage.connect(GetHit)	
	healthManager.SetLifeBase(lifeBase)
	
	timerIdle.wait_time = timeIdle
	timerIdle.one_shot = true
	timerIdle.autostart = false
	timerIdle.timeout.connect(TimerIdleTimeout)
	pass

func _physics_process(delta) -> void:
	match currentState:
		States.IDLE:
			moveComponent.Move(self, Vector2.ZERO, delta, 1300, speed)
			animPlayer.play("Idle")
			
			## Se movimentou até o proximo ponto, quando chegar já ataca
			if timerIdle.is_stopped():
				timerIdle.start()
				ChangeState(States.ATTACK)
			pass
			
		States.CHASING:
			_currentTimeCheckStuck += delta
			if _currentTimeCheckStuck > _timeCheckIfStuck:
				_currentTimeCheckStuck = 0
				if _lastPositionCheckStuck.distance_to(global_position) < 3.0:
					ChangeState(States.IDLE)
					return
				else:
					_lastPositionCheckStuck = global_position
			
			if global_position.distance_to(nextPostion) < 16.0:
				ChangeState(States.IDLE)
				return
				
			animPlayer.play("Walk")
			var nextPositionDirection = (nextPostion - self.global_position).normalized()
			moveComponent.Move(self, nextPositionDirection, delta, 1300, speed)
			pass

		States.ATTACK:
			moveComponent.Move(self, Vector2.ZERO, delta, 1300, speed)
			animPlayer.play("Attack")
			pass
			
func GetHit(attack: Attack) -> void:
	flashHit.Flash(sprite.material)
	pass

func ChangeState(state: States) -> void:
	currentState = state
	pass
	
func AttackFinished() -> void:
	shootManager.JustFire(playerTracker.GetDirection(), orcMageBulletStats)
	ChangeState(States.IDLE)
	pass
	
func SetNextPosition() -> void:
	nextPostion = playerTracker.GetPosition()
	
func TimerIdleTimeout() -> void:
	var randTime = rnd.randf_range(0.0, 1.0)
	timerIdle.wait_time = randTime + timeIdle
	SetNextPosition()
	ChangeState(States.CHASING)
