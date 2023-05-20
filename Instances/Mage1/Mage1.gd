extends CharacterBody2D

@export var moveComponent : MoveComponent
@export var acceleration := 800.0
@export var speed := 200.0

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var animationPlayer := $AnimationPlayer as AnimationPlayer

var isAlive = true

func _ready():
	animationPlayer.play("Idle")

func _physics_process(delta):
	if !isAlive:
		return
	
	var input = getAxisInput()
	moveComponent.Move(self, input, delta, acceleration, speed)
		
	

func getAxisInput() -> Vector2:
	var directionH = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var directionV = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")	
	
	return Vector2 (directionH, directionV).normalized()
