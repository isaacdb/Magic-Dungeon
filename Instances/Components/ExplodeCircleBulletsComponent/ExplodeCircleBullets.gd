extends Node2D
class_name ExplodeCircleBullets

@export var bulletAmount : int = 4
@export var bullet : BulletStats

@onready var shooter = $ShooterComponent as ShooterComponent
@onready var rnd := RandomNumberGenerator.new()

func _ready():
	rnd.randomize();
	Explode();
	pass
	
func Explode() -> void:
	prints("amount", bulletAmount, "bullet double?", bullet.bulletFireAmount)
	var angleBetweenBullets := 360.0 / bulletAmount
	var angleFire = rnd.randf_range(0.0, 90.0) # Add random first angle
	for i in bulletAmount:
		shooter.JustFire(Vector2.RIGHT.rotated(deg_to_rad(angleFire)), bullet)
		angleFire += angleBetweenBullets
	
	queue_free();
	pass
