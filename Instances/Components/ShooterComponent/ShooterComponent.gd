extends Node2D
class_name ShooterComponent

@export_enum("None:-1", "Player:0", "Enemy:1") var origin = "Player"
@export var fireDelay := 0.0

@onready var fireTimer := $Timer as Timer
@onready var bullet := preload("res://Instances/Bullet/BulletsEnemies/BulletEnemy1/BulletEnemy1.tscn")

var canShoot := false
var isActive := false

func _ready():
	fireTimer.connect("timeout", FireTimerTimeout)
	fireTimer.set_wait_time(fireDelay)
	fireTimer.set_one_shot(false)
	pass

func SetActive(active: bool):
	isActive = active
	pass

func Fire(direction: Vector2):
	if !isActive:
		return
	
	var newBullet = bullet.instantiate()
	get_tree().get_root().get_child(0).add_child(newBullet)
	newBullet.global_position = self.global_position
	
#	var targetDirection = (get_global_mouse_position() - spawnPoint.global_position).normalized()
	newBullet.moveDirection = direction
	newBullet.look_at(self.global_position + (direction * 10))
	canShoot = false
	fireTimer.start()
	pass
	
func FireTimerTimeout():
	canShoot = true
	pass
