extends Marker2D
class_name ShooterComponent

@export var fireRate := 0.0
@export var fireAudio : AudioStream

@onready var fireTimer := $Timer as Timer
@onready var audioPlayer := $AudioStreamPlayer2D as AudioStreamPlayer2D

var canShoot := false

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

func FireWithCooldown(direction: Vector2, bulletStats: BulletStats):
	if !canShoot:
		return false
	
	Shoot(direction, bulletStats)
	
	canShoot = false
	fireTimer.start()
	return true
	
func JustFire(direction: Vector2, bulletStats: BulletStats):
	Shoot(direction, bulletStats)
	pass

func Shoot(direction: Vector2, bulletStats: BulletStats):	
	for i in bulletStats.bulletFireAmount:
		var bulletDirection = direction
		if bulletStats.bulletFireAmount > 1:
			bulletDirection = GetDirectionBulletBySpread(direction, bulletStats, i);
			pass
		
		#Need use call_deferred to can use this component on explodeEnemyUpgrade
		call_deferred("InstatiateBullet", bulletDirection, bulletStats)
		pass
		
	if fireAudio:
		audioPlayer.play()
	pass
	
func GetDirectionBulletBySpread(direction: Vector2, bulletStats: BulletStats, numBullet: float) -> Vector2:
	var angleBetween = bulletStats.angleSpread / (bulletStats.bulletFireAmount - 1);
	var startAngle = direction.rotated(deg_to_rad( - bulletStats.angleSpread / 2))
	return startAngle.rotated(deg_to_rad(angleBetween * numBullet))
	
func InstatiateBullet(direction: Vector2, bulletStats: BulletStats) -> void:
	var newBullet = bulletStats.prefab.instantiate() as Bullet
	var bulletParent = get_tree().get_first_node_in_group("BulletParent") as Node
	if bulletParent:
		bulletParent.add_child(newBullet);
	else:
		self.add_child(newBullet);
	newBullet.look_at(self.global_position + (direction * 10))
	newBullet.UpdateStats(bulletStats)
	newBullet.SetupPositionAndDirection(direction, self.global_position);
	pass
	
func FireTimerTimeout():
	canShoot = true
	pass
