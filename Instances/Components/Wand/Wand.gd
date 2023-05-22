extends Node2D
class_name Wand

@export var shootManager : ShooterComponent
@export var wandBulletStats : BulletStats

@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var wandBullet := preload("res://Instances/Bullet/BulletsEnemies/BulletEnemy1/BulletN.tscn")

var isActive := false

func _ready():
	shootManager.UpdateFireRate(1)
	pass

func UpdateFireRate(newFireRate: float):
	shootManager.UpdateFireRate(newFireRate)
	pass

func _physics_process(delta):
	if !isActive:
		return
	
	if Input.is_action_pressed("fire"):
		Fire()

func SetActive(active: bool):
	isActive = active
	pass

func Fire():	
	var targetDirection = (get_global_mouse_position() - shootManager.global_position).normalized()	
	var shoot = shootManager.Fire(targetDirection, wandBullet, wandBulletStats)
	if shoot:
		animationPlayer.play("Fired")
