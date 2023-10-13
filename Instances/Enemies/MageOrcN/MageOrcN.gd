extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var flashHit : FlashHit

@export var orcMageBulletStats : BulletStats
@export var lifeBase := 5
@export var speed := 80.0
@export var maxDistanceToWalk := 100

@export var timeIdle := 1.0
@onready var timerIdle := $TimerIdle as Timer
@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var deslocateToPlayer = $DeslocateToPlayer as DescolateToPlayer

@onready var rnd := RandomNumberGenerator.new()

enum States
{
	IDLE,
	CHASING,
	ATTACK,
}

var currentState := States.IDLE
var nextPosition := Vector2.ZERO

func _ready() -> void:
	healthManager.SetLifeBase(lifeBase)
	timerIdle.timeout.connect(TimerIdleTimeout)
	pass

func _physics_process(delta) -> void:
	match currentState:
		States.IDLE:
			if timerIdle.is_stopped():
				var randTime = rnd.randf_range(0.0, 1.0)
				timerIdle.wait_time = timeIdle + randTime;
				timerIdle.start();
			pass
			
		States.CHASING:
			if nextPosition.distance_to(global_position) < 10:
				ChangeState(States.ATTACK);
				return
			
			animPlayer.play("Walk")
			moveComponent.Move(self, GetDirectionToNextPosition(), delta, 1300, speed)
			
			if get_slide_collision_count():
				var collision = get_slide_collision(0);
				nextPosition = global_position + (GetDirectionToNextPosition().bounce(collision.get_normal()) * 20)
				return
				
			pass

		States.ATTACK:
			animPlayer.play("Attack")
			pass
			
func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished() -> void:
	ChangeState(States.IDLE)
	pass

func Shoot():
	shootManager.JustFire(playerTracker.GetDirection(), orcMageBulletStats)
	pass
	
func TimerIdleTimeout() -> void:
	nextPosition = deslocateToPlayer.GetNextPosition(playerTracker.GetDirection(), GetDistanceToWalk(), 45) + global_position;	
	ChangeState(States.CHASING)
	
func GetDirectionToNextPosition() -> Vector2:
	return (nextPosition - self.global_position).normalized()
	
func GetDistanceToWalk() -> float:
	if playerTracker.GetDistance() < maxDistanceToWalk:
		return playerTracker.GetDistance()
	
	return  maxDistanceToWalk;
