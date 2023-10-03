extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var flashHit : FlashHit

# Combat vars
@export var damage := 1.0
@export var attackDelay := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 8.0
@export var speed := 50.0

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var rnd := RandomNumberGenerator.new()

@export var orcLowBulletStats : BulletStats

enum States
{
	CHASING,
	ATTACK,
	DEATH
}

var currentState := States.CHASING
var roundDirection := 1

var tweenAttack : Tween

func _ready():
	healthManager.SetLifeBase(lifeBase)
	pass
	
func _physics_process(delta):
	match currentState:
		States.CHASING:
			if !tweenAttack or !tweenAttack.is_running():
				var randTime = rnd.randf_range(0.0, 1.0)
				tweenAttack = create_tween()
				tweenAttack.tween_callback(func(): ChangeState(States.ATTACK)).set_delay(attackDelay + randTime)
				roundDirection = 1 if rnd.randf() > 0.5 else -1
			
			animPlayer.play("Walk")
			moveComponent.Move(self, GetDirection(), delta, 1300, speed)
			pass
			
		States.ATTACK:
			animPlayer.play("Attack")
			pass

func ChangeState(state: States):
	currentState = state
	pass
	
func AttackFinished():
	shootManager.FireWithCooldown(playerTracker.GetDirection(), orcLowBulletStats)
	ChangeState(States.CHASING)
	pass
	
func GetDirection() -> Vector2:
	if playerTracker.GetDistance() >= 80.0:
		return playerTracker.GetDirection()
	else:
		var directionRounded = Vector2(-playerTracker.GetDirection().y, playerTracker.GetDirection().x)
		return directionRounded * roundDirection
