extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var flashHit : FlashHit

# Combat vars
@export var timeIdle := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 8.0
@export var speed := 50.0
@export var maxDistanceToWalk := 150

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var rnd := RandomNumberGenerator.new()
@onready var deslocateToPlayer = $DeslocateToPlayer as DescolateToPlayer
@onready var timerIdle = $TimerIdle as Timer

@export var orcLowBulletStats : BulletStats

enum States
{
	CHASING,
	ATTACK,
	IDLE
}

var currentState := States.IDLE
var nextPosition := Vector2.ZERO

func _ready():
	if randf() > 0.5: currentState = States.ATTACK;
	healthManager.SetLifeBase(lifeBase)
	timerIdle.timeout.connect(EndIdleState)
	pass
	
func _physics_process(delta):
	match currentState:
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
			
		States.IDLE:
			if timerIdle.is_stopped():
				var randTime = rnd.randf_range(0.0, 1.0)
				timerIdle.wait_time = timeIdle + randTime;
				timerIdle.start();
			pass

func EndIdleState() -> void:
	nextPosition = deslocateToPlayer.GetNextPosition(playerTracker.GetDirection(), GetDistanceToWalk(), 45) + global_position;
	ChangeState(States.CHASING);
	pass

func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished():
	shootManager.JustFire(playerTracker.GetDirection(), orcLowBulletStats)
	ChangeState(States.IDLE)
	pass

func GetDirectionToNextPosition() -> Vector2:
	return (nextPosition - self.global_position).normalized()
	
func GetDistanceToWalk() -> float:
	if playerTracker.GetDistance() < maxDistanceToWalk:
		return playerTracker.GetDistance()
	
	return  maxDistanceToWalk;
