extends CharacterBody2D
class_name Bullet

# CRIMSON = RED
var enemyColor :=  Color(0.862745, 0.0784314, 0.235294, 1)
# ANTIQUE_WHITE
var playerColor := Color(0.980392, 0.921569, 0.843137, 1)

@onready var timer := $Timer as Timer
@onready var sprite := $Sprite2D as AnimatedSprite2D
@onready var lineTrail := $Line2D as Line2D
@onready var hitBox := $HitBox as HitBoxComponent
@onready var impactParticle := $ImpactPaticle as CPUParticles2D
@onready var player_tracker = $PlayerTracker as PlayerTracker

var speed := 0.0
var isRunning := true
var currentBulletStats : BulletStats
var moveDirection := Vector2.ZERO
var piercingShots := 0
var currentPiercingsShots := 0
var bounceTimes := 0
var currentBounceTimes := 0
var lifeTime := 0.0
var follow_player := true
var follow_player_weight := 0.02

func _ready():
	hitBox.monitoring = true
	hitBox.monitorable = true # Have to be true, just bc a bug, its required for collision with tileemap
	
	hitBox.connect("attack_enter", HitBody)
	pass
	
func HitBody() -> void:
	if currentPiercingsShots < piercingShots:
		currentPiercingsShots += 1;
		return
		
	Destroy()
	pass
	
func SetupPositionAndDirection(direction: Vector2, spawnPosition: Vector2) -> void:
	global_position = spawnPosition;
	moveDirection = direction;
	pass

func IsOriginPlayer() -> bool:
	return currentBulletStats.origin == "Player";

func IsOriginEnemy() -> bool:
	return currentBulletStats.origin == "Enemy";

func UpdateStats(bulletStats: BulletStats):
	currentBulletStats = bulletStats
	match bulletStats.origin:
		"None":
			print("Bullet origin is MISSING!!")
		"Player":
			hitBox.set_collision_mask_value(4, true) #Collision with enemy hurtBox
			hitBox.set_collision_layer_value(1, true)
			#sprite.modulate = playerColor
			sprite.material.set("shader_parameter/base_color", playerColor)
			lineTrail.modulate = playerColor
			impactParticle.modulate = playerColor
		"Enemy":
			hitBox.set_collision_mask_value(2, true) #Collision with player hurtBox
			hitBox.set_collision_layer_value(3, true)
			#sprite.modulate = enemyColor
			sprite.material.set("shader_parameter/base_color", enemyColor)
			lineTrail.modulate = enemyColor
			impactParticle.modulate = enemyColor
			
	sprite.play(bulletStats.bulletSpriteAnim)
	
	if bulletStats.bulletSpriteAnim == "Fire1":
		sprite.offset.y = -12;
		global_rotation_degrees = 0
	elif bulletStats.bulletSpriteAnim == "Fire3":
		sprite.offset.y = -8;
		global_rotation_degrees = 0
	else:
		sprite.offset.y = 0;
	
	lineTrail.visible = bulletStats.line_trail_active
	speed = bulletStats.speed
	lifeTime = bulletStats.lifeTime
	piercingShots = bulletStats.piercingShots
	bounceTimes = bulletStats.bounceTimes
	hitBox.damage = bulletStats.damage
	hitBox.knockBackForce = bulletStats.knockBackForce
	follow_player = bulletStats.follow_player
	follow_player_weight = bulletStats.follow_player_weight

	timer.one_shot = true
	timer.wait_time = lifeTime;
	timer.timeout.connect(timer_life_timeout)
	timer.start()

func _physics_process(delta):
	if not isRunning:
		return
	
	if follow_player:
		moveDirection = moveDirection.lerp(player_tracker.GetDirection(), follow_player_weight);
	
	var collision = move_and_collide(speed * moveDirection * delta)
	if collision:
		WorldCollision(collision);
	pass
	
func Destroy():
	timer.stop();
	if timer.timeout.is_connected(timer_life_timeout):
		timer.timeout.disconnect(timer_life_timeout)
	isRunning = false
	#collisionShape.set_deferred("Disabled", true)
	hitBox.queue_free()
	sprite.queue_free()

	impactParticle.emitting = true
	
	await get_tree().create_timer(1.5).timeout
	
	self.queue_free()
	pass

func WorldCollision(collision: KinematicCollision2D):
	if currentBounceTimes < bounceTimes:
		Bounce(collision);
		return
	
	SetParticleToWallCollision()
	Destroy()
	pass
	
func Bounce(collision: KinematicCollision2D) -> void:
	moveDirection = moveDirection.bounce(collision.get_normal())
	currentBounceTimes += 1
	pass

func SetParticleToWallCollision():
	impactParticle.rotate(deg_to_rad(180))
	impactParticle.spread = 180
	impactParticle.initial_velocity_min = 100
	impactParticle.initial_velocity_min = 150
	pass

func timer_life_timeout() -> void:
	impactParticle.rotate(deg_to_rad(-90))
	impactParticle.spread = 90
	impactParticle.initial_velocity_min = 100
	impactParticle.initial_velocity_min = 150
	
	Destroy();
	pass
