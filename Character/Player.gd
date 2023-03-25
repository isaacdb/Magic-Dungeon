extends CharacterBody2D

@export var speed = 200
@export var acceleration = 800
@export var friction = 20
@export var spriteTexture : CompressedTexture2D
@export var lifeBase := 10

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer

var currentLife := lifeBase

func _ready():
	animationPlayer.play("Idle")
	pass 

func _process(delta):
	_move(delta)
	pass
		
	
func _move(delta):
	var directionH = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionV = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	
	var direction = Vector2 (directionH, directionV).normalized()
	
	if direction:
		velocity = velocity.move_toward(direction * speed, acceleration * delta)
	else:
		velocity = velocity.lerp(Vector2.ZERO, minf(friction * delta, 1.0))
		
	move_and_slide()
	
	sprite2D.flip_h = (get_global_mouse_position() - position).x < 0
	sprite2D.rotation_degrees = directionH * 5
	pass
	
func take_damage(damage):
	currentLife -= damage
	print(currentLife)
	
	pass
