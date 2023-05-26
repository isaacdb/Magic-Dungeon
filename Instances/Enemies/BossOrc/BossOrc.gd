extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var shootManager : ShooterComponent
@export var flashHit : FlashHit
@export var attackManager : AttackManager

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
@onready var rnd := RandomNumberGenerator.new()

@export var orcLowBulletStats : BulletStats

enum States
{
	IDLE,
	CHASING,
	ATTACK,
	DEATH
}

var tweenIdle : Tween
var tweenWalk : Tween

var currentState := States.CHASING
var nextPostion := Vector2.ZERO

func _ready():	
	healthManager.damage.connect(GetHit)
	healthManager.SetLifeBase(lifeBase)
	healthManager.lifeBar.UpdateHealthBar(lifeBase)
	
	rnd.randomize()
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:			
			## Se movimentou até o proximo ponto, quando chegar já ataca
			if !tweenIdle or !tweenIdle.is_running():
				var randTime = rnd.randf_range(0.0, 1.0)
				tweenIdle = create_tween()
				tweenIdle.tween_callback(func(): ChangeState(States.CHASING)).set_delay(timeIdle + randTime)
				ChangeState(States.ATTACK)
				
			animPlayer.play("Idle")
			pass
			
		States.CHASING:
			## Contagem de tempo que ficará perseguindo
			if !tweenWalk or !tweenWalk.is_running():
				var randTime = rnd.randf_range(0.0, 1.0)
				tweenWalk = create_tween()
				tweenWalk.tween_callback(func(): ChangeState(States.IDLE)).set_delay(timeWalk + randTime)
			
			if playerTracker.GetDistance() < 5.0:
				tweenWalk.stop()
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
	attackManager.Execute()
#	shootManager.FireWithCooldown(playerTracker.GetDirection(), orcLowBulletStats)
	ChangeState(States.IDLE)
	pass
	
func GetHit():
	flashHit.Flash(sprite.material)
	pass
