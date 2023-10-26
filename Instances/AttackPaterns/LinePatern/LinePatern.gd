extends Node2D
class_name LinePatern

@onready var shooter := $ShooterComponent as ShooterComponent
@onready var playerTrack := $PlayerTracker as PlayerTracker

@export var fireAmount : int = 1
@export var delayBetweenFire : float = 0.1
@export var bullet : BulletStats

var direction : Vector2
var attackManager : AttackManager

func _ready():
	attackManager = get_parent() as AttackManager
	pass

func Execute():
	direction = playerTrack.GetDirection()
	
	var tween = create_tween().set_loops(fireAmount)
	tween.tween_callback(Fire).set_delay(delayBetweenFire)
	tween.finished.connect(func(): attackManager.AttackCompleted())
	tween.play()
	pass
	
func Fire():
	shooter.JustFire(direction, bullet)
	pass
