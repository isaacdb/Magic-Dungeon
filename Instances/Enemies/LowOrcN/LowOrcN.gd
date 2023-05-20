extends CharacterBody2D

@export var spawnEffect : Node2D
@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var attackManager : AttackManager
@export var healthManager : Health
@export var speed := 50.0

@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $AnimatedSprite2D as AnimatedSprite2D

enum States
{
	IDLE,
	CHASING,
	HIT,
	ATTACK,
	DEATH,
	SPAWNING
}

var currentState := States.SPAWNING

func _ready():
	attackManager.connect("attack_signal", func(): ChangeState(States.ATTACK))
	healthManager.connect("damage", func(): ChangeState(States.HIT))
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:
			animPlayer.play("Idle")
			if !attackManager.playerInRange:
					ChangeState(States.CHASING)
			pass
			
		States.SPAWNING:
			sprite.visible = false
			spawnEffect.Execute()
			if spawnEffect.isSpawned:
				ChangeState(States.CHASING)
				sprite.visible = true
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
