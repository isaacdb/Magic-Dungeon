extends Node2D
class_name EspiralPatern

@onready var shooter := $ShooterComponent as ShooterComponent
@onready var rnd := RandomNumberGenerator.new()

@export var bulletAmount : int = 4
@export var fireAmount : int = 4
@export var anglePerFire : float = 10.0
@export var delayBetweenFire : float = 0.5
@export var bullet : BulletStats

var angleFire : float = 0.0
var attackManager : AttackManager

func _ready():
	rnd.randomize()
	attackManager = get_parent() as AttackManager
	pass

func Execute():
	rotation_degrees = 0
	angleFire = rnd.randf_range(0.0, 90.0) # Add random first angle
	
	var tween = create_tween().set_loops(fireAmount)
	tween.tween_callback(Fire).set_delay(delayBetweenFire)
	tween.finished.connect(func(): attackManager.AttackCompleted())
	tween.play()
	pass
	
func Fire():
	rotation_degrees += anglePerFire
	var angleBetweenBullets := 360.0 / bulletAmount
	
	for i in bulletAmount:
		shooter.JustFire(Vector2.RIGHT.rotated(deg_to_rad(rotation_degrees + angleFire)), bullet)
		angleFire += angleBetweenBullets
	pass
