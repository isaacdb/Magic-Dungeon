extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var healthManager : Health
@export var deathManager : DeathManager
@export var shootManager : ShooterComponent
@export var speed := 80.0

@export var miniOrcBulletStats : BulletStats

@export var lifeBase := 5.0
@export var timeUntilExplode := 5.0

@onready var timerToExplode := $TimerToExpode as Timer
@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $GroupFlip/AnimatedSprite2D as AnimatedSprite2D
@onready var orcBullet := preload("res://Instances/Bullet/BulletsEnemies/BulletEnemy1/BulletN.tscn")
@onready var rnd := RandomNumberGenerator.new()

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
	healthManager.connect("damage", func(): ChangeState(States.HIT))	
	healthManager.SetLifeBase(lifeBase)
	
	var randTime = rnd.randf_range(-1.5, 1.5)	
	timerToExplode.wait_time = timeUntilExplode + randTime
	timerToExplode.one_shot = true
	timerToExplode.autostart = false
	timerToExplode.timeout.connect(TimerUtilExplodeTimeout)
	timerToExplode.start()
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:
			animPlayer.play("Idle")
			
			if global_position.distance_to(playerTracker.playerTrack.position) > 2.0:
				ChangeState(States.CHASING)
			pass
			
		States.CHASING:
			animPlayer.play("Walk")
			moveComponent.Move(self, playerTracker.GetDirection(), delta, 1300, speed)		

			if global_position.distance_to(playerTracker.playerTrack.position) < 2.0:
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
	var angleFire = rnd.randf_range(0.0, 90.0)
	for i in 4:
		shootManager.JustFire(Vector2.RIGHT.rotated(deg_to_rad(angleFire)), orcBullet, miniOrcBulletStats)
		angleFire += 90.0
		
	deathManager.Execute()
	pass
	
func HitFinished():
	print("mini orc hitted")
	ChangeState(States.IDLE)
	pass	
	
func TimerUtilExplodeTimeout():
	ChangeState(States.ATTACK)
