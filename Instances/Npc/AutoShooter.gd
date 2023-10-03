extends Node2D

@export var delayShooting := 2.0
@export var bulletStat : BulletStats

@onready var shooterComponent := $ShooterComponent as ShooterComponent

func _ready() -> void:
	shooterComponent.UpdateFireRate(delayShooting)
	pass

func _physics_process(delta) -> void:
	Shoot();
	pass
	
func Shoot() -> void:
	shooterComponent.FireWithCooldown(Vector2.RIGHT.rotated(rotation), bulletStat);
	pass
	
