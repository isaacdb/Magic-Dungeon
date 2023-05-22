extends CharacterBody2D

@export var spawnEffect : Node2D
@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var attackManager : AttackManager
@export var healthManager : Health
@export var hitBox : HitBoxComponent

@export var speed := 50.0

# Combat vars
@export var damage := 1.0
@export var attackDelay := 1.5
@export var knockBackForce := 300.0
@export var lifeBase := 8.0

@export var timeEscaping := 1.0

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var timerScape := $TimerEscape as Timer
@onready var rnd := RandomNumberGenerator.new()

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

func _ready():	
	attackManager.connect("attack_signal", func(): ChangeState(States.ATTACK))
	healthManager.connect("damage", func(): ChangeState(States.HIT))
	
	attackManager.SetAttackDelay(attackDelay)
	healthManager.SetLifeBase(lifeBase)
	
	hitBox.damage = damage
	hitBox.knockBackForce = knockBackForce	
	
	timerScape.wait_time = timeEscaping
	timerScape.one_shot = true
	timerScape.autostart = false
	timerScape.timeout.connect(TimerScapeTimeout)
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
			var playerDirection = (playerTracker.playerTrack.global_position - self.global_position).normalized()
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
	ChangeState(States.IDLE)
	pass
	
func HitFinished():
	ChangeState(States.IDLE)
	pass	

func TimerScapeTimeout():
	ChangeState(States.IDLE)
