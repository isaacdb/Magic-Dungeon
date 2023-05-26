extends Node2D
class_name ArcPatern

@onready var shooter := $ShooterComponent as ShooterComponent
@onready var playerTrack := $PlayerTracker as PlayerTracker
@onready var rnd := RandomNumberGenerator.new()

@export var fireAmount : int = 5
@export var anglePerFire : float = 2.0
@export var delayBetweenFire : float = 0.1
@export var bullet : BulletStats

var angleFire : float = 0.0
var firstBulletFired : bool = false

var direction : Vector2

func _ready():
	rnd.randomize()
	pass

func Execute():
	direction = playerTrack.GetDirection()
	angleFire = 0.0
	firstBulletFired = false
	
	var tween = create_tween().set_loops(fireAmount)
	tween.tween_callback(Fire).set_delay(delayBetweenFire)
	tween.play()
	pass
	
func Fire():
	if !firstBulletFired:
		shooter.JustFire(direction, bullet)
		firstBulletFired = true
	else:
		angleFire += anglePerFire
		shooter.JustFire(Vector2.RIGHT.rotated(direction.angle() + deg_to_rad(angleFire)), bullet)
		shooter.JustFire(Vector2.RIGHT.rotated(direction.angle() - deg_to_rad(angleFire)), bullet)
		
	pass
