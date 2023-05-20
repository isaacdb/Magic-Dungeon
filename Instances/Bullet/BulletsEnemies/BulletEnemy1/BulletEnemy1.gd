extends Node2D

@export var speed := 600.0
@export var moveDirection := Vector2.ZERO
@export var damage := 0.0

@onready var timer := $Timer as Timer
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $Sprite2D as AnimatedSprite2D
@onready var hitBox := $HitBox as HitBoxComponent

var velocity := Vector2.ZERO
var isRunning := true

func _ready():
	timer.one_shot = true
	hitBox.connect("attack_enter", Destroy)
	pass

func _physics_process(delta):
	if isRunning:
		velocity = speed * moveDirection * delta	
		translate(velocity)	
	pass
	
func Destroy():
	isRunning = false	
	Global.emit_signal("screen_shake", .5, .1, 1)
	#collisionShape.set_deferred("Disabled", true)
	hitBox.queue_free()
	animationPlayer.play("Hit")
	
	timer.wait_time = 1.5
	timer.start()
	
	await timer.timeout
	
	self.queue_free()	
	pass


