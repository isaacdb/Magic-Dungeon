extends Node2D

@export var fireDelay := 0.5

@onready var bullet := preload("res://Instances/Bullet/Bullet.tscn")
@onready var sprite2D := $Sprite2D as Sprite2D
@onready var fireTimer := $Timer as Timer
@onready var spawnPoint := $Sprite2D/Marker2D as Marker2D

var offSetSpawnPoint := 0
var canShoot := true

func _ready():
	offSetSpawnPoint = spawnPoint.position.y
	
	fireTimer.connect("timeout", _fireTimer_timeout)
	fireTimer.set_wait_time(fireDelay)
	fireTimer.set_one_shot(true)
	pass

func _physics_process(delta):
	look_at(get_global_mouse_position())
	sprite2D.flip_h = (get_global_mouse_position() - global_position).x < 0
	sprite2D.flip_v = (get_global_mouse_position() - global_position).x < 0	
	
	if sprite2D.flip_v:
		spawnPoint.position.y = offSetSpawnPoint * -1
	else:
		spawnPoint.position.y = offSetSpawnPoint
		
	if Input.is_action_pressed("fire") and canShoot:
		_fire()
	pass

func _fire():
	var newBullet = bullet.instantiate()
	newBullet.origin = "Player"
	get_tree().get_root().add_child(newBullet)
	newBullet.global_position = spawnPoint.global_position
	
	var targetDirection = (get_global_mouse_position() - spawnPoint.global_position).normalized()
	newBullet.moveDirection = targetDirection
	canShoot = false
	fireTimer.start()
	pass
	
func _fireTimer_timeout():
	canShoot = true
	pass
