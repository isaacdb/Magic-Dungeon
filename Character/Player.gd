extends CharacterBody2D

@export var speed = 200
@export var acceleration = 800
@export var friction = 800
@export var spriteTexture : CompressedTexture2D

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer

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
	
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	move_and_slide()
	
	sprite2D.flip_h = (get_global_mouse_position() - position).x < 0
