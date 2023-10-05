extends Marker2D
class_name ShooterComponent

@export var fireRate := 0.0
@export var fireAudio : AudioStream

@onready var fireTimer := $Timer as Timer
@onready var audioPlayer := $AudioStreamPlayer2D as AudioStreamPlayer2D

var canShoot := false
var isActive := true

func _ready():
	fireTimer.connect("timeout", FireTimerTimeout)
	fireTimer.set_one_shot(true)
	fireTimer.start()
	
	if fireAudio:
		audioPlayer.stream = fireAudio
	
	pass

func UpdateFireRate(newFireRate: float):
	fireRate = newFireRate
	fireTimer.set_wait_time(fireRate)
	fireTimer.start()

func SetActive(active: bool):
	isActive = active
	pass

func FireWithCooldown(direction: Vector2, bulletStats: BulletStats):
	if !isActive or !canShoot:
		return false
	
	Shoot(direction, bulletStats)
	
	canShoot = false
	fireTimer.start()	
	return true
	
func JustFire(direction: Vector2, bulletStats: BulletStats):
	Shoot(direction, bulletStats)
	pass

func Shoot(direction: Vector2, bulletStats: BulletStats):
	var newBullet = bulletStats.prefab.instantiate() as BulletN
	get_tree().get_root().get_child(4).add_child(newBullet)
	newBullet.UpdateStats(bulletStats)
	newBullet.global_position = self.global_position
	newBullet.moveDirection = direction
	newBullet.look_at(self.global_position + (direction * 10))
	
	if fireAudio && Settings.soundEffect:
		audioPlayer.play()
		
	pass
	
func FireTimerTimeout():
	canShoot = true
	pass
