extends Marker2D
class_name ShooterComponent

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

func FireWithCooldown(direction: Vector2, bullet, bulletStats: BulletStats):
	if !isActive or !canShoot:
		return false
	
	Shoot(direction, bullet, bulletStats)
	
	canShoot = false
	fireTimer.start()	
	return true
	
func JustFire(direction: Vector2, bullet, bulletStats: BulletStats):
	Shoot(direction, bullet, bulletStats)
	pass

func Shoot(direction: Vector2, bullet, bulletStats: BulletStats):
	var newBullet = bullet.instantiate()
	get_tree().get_root().get_child(0).add_child(newBullet)
	newBullet.UpdateStats(bulletStats)
	newBullet.global_position = self.global_position
	newBullet.moveDirection = direction
	newBullet.look_at(self.global_position + (direction * 10))		
	pass
	
func FireTimerTimeout():
	canShoot = true
	pass
