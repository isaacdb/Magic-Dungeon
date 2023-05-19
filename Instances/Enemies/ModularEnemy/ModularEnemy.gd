extends CharacterBody2D

@export var spawnEffect : Node2D
@export var moveComponent : MoveComponent
@export var playerTracker : PlayerTracker
@export var attackManager : AttackManager

@onready var animPlayer := $AnimationPlayer as AnimationPlayer

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
	attackManager.attack_signal.connect(func(): ChangeState(States.ATTACK))
	pass
	
func _physics_process(delta):
	match currentState:
		States.IDLE:
			animPlayer.play("Idle")
			if !attackManager.playerInRange:
					ChangeState(States.CHASING)
			pass
			
		States.SPAWNING:			
			spawnEffect.Execute()
			if spawnEffect.isSpawned:
				currentState = States.CHASING
			pass
			
		States.CHASING:
			animPlayer.play("Walk")
			var playerDirection = (playerTracker.playerTrack.global_position - self.global_position).normalized()
			moveComponent.Move(self, playerDirection, delta)
			
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
