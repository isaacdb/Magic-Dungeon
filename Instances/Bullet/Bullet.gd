extends Area2D

@export var speed := 600.0
@export var moveDirection := Vector2.ZERO
@export var damage := 0.0
@export_enum("None:-1", "Player:0", "Enemy:1") var origin = "Player"

@onready var timer := $Timer as Timer
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var collisionShape := $CollisionShape2D as CollisionShape2D
@onready var sprite := $Sprite2D as AnimatedSprite2D

var velocity := Vector2.ZERO
var isRunning := true

func _ready():
	set_collision_mask_value(6, true) # World collision
	match origin:
		"None":
			print("Bullet origin is MISSING!!")
		"Player":
			set_collision_mask_value(4, true) #Collision with enemy hurtBox
		"Enemy":
			set_collision_mask_value(2, true) #Collision with player hurtBox			
			set_collision_mask_value(1, true)
	
	monitoring = true
	monitorable = true # Have to be true, just bc a bug, its required for collision with tileemap
	
	timer.one_shot = true
	
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_area_entered)
	
	pass


func _physics_process(delta):
	if isRunning:
		velocity = speed * moveDirection * delta	
		translate(velocity)			
	pass

	
func _on_body_entered(body):
	if !isRunning:
		return
		
	if body.has_method("take_damage"):
		body.take_damage(damage, moveDirection)
		
	_destroy()
	pass


func _on_area_entered(area):
	if !isRunning:
		return
		
	if area.has_method("take_damage"):
		var attack = Attack.new()
		attack.damage = damage
		attack.direction = moveDirection
		attack.knock_back = 10
		area.take_damage(attack)
		
	_destroy()
	pass
	
	
func _destroy():
	isRunning = false	
	Global.emit_signal("screen_shake", .5, .1, 1)
	collisionShape.set_deferred("Disabled", true)
	animationPlayer.play("Hit")
	
	timer.wait_time = 1.5
	timer.start()
	
	await timer.timeout
	
	self.queue_free()	
	pass


