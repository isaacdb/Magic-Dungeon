extends Marker2D
class_name ShooterComponent

@export_enum("None:-1", "Player:0", "Enemy:1") var origin = "Player"
@export var fireRate := 0.0

@onready var fireTimer := $Timer as Timer

var canShoot := false
var isActive := true

func _ready():
	fireTimer.connect("timeout", FireTimerTimeout)
	fireTimer.set_one_shot(true)
	fireTimer.start()
	pass

func UpdateFireRate(newFireRate: float):
	fireRate = newFireRate
	fireTimer.set_wait_time(fireRate)
	fireTimer.start()

func SetActive(active: bool):
	isActive = active
	pass

func Fire(direction: Vector2, bullet) -> bool:
	if !isActive or !canShoot:
		return false
	
	var newBullet = bullet.instantiate()
	get_tree().get_root().get_child(0).add_child(newBullet)
	newBullet.global_position = self.global_position
	
#	var targetDirection = (get_global_mouse_position() - spawnPoint.global_position).normalized()
	newBullet.moveDirection = direction
	newBullet.look_at(self.global_position + (direction * 10))
	canShoot = false
	fireTimer.start()
	
	return true
	
func FireTimerTimeout():
	canShoot = true
	pass
