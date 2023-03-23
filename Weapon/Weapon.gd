extends Node2D

@onready var sprite2D := $Sprite2D as Sprite2D

var offSetWeapon := 0

func _ready():
	offSetWeapon = sprite2D.offset.x
	pass

func _physics_process(delta):
	look_at(get_global_mouse_position())
	sprite2D.flip_h = (get_global_mouse_position() - global_position).x < 0
	sprite2D.flip_v = (get_global_mouse_position() - global_position).x < 0
	
	pass
