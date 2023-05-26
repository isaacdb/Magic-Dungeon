extends Node2D
class_name CirclePatern

@onready var shooter := $ShooterComponent as ShooterComponent
@onready var rnd := RandomNumberGenerator.new()

@export var bulletAmount : int = 4
@export var bullet : BulletStats

func _ready():
	rnd.randomize()
	pass

func Execute():
	var angleBetweenBullets := 360.0 / bulletAmount
	var angleFire = rnd.randf_range(0.0, 90.0) # Add random first angle
	for i in bulletAmount:
		shooter.JustFire(Vector2.RIGHT.rotated(deg_to_rad(angleFire)), bullet)
		angleFire += angleBetweenBullets
	pass
