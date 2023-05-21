extends Node2D

@export var shootManager : ShooterComponent
@export var fireRate := 0.0

@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var wandBullet := preload("res://Instances/Bullet/Bullet.tscn")

var isActive := false

func _ready():
	shootManager.UpdateFireRate(fireRate)
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
	var shoot = shootManager.Fire(targetDirection, wandBullet)
	if shoot:
		animationPlayer.play("Fire")	
