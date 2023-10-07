extends Node2D

@onready var sprite2D := $Sprite2D as Sprite2D
@onready var spawnPoint := $ShooterComponent as Marker2D

var offSetSpawnPoint := 0.0

func _ready():
	offSetSpawnPoint = spawnPoint.position.y

func _physics_process(delta):
	self.look_at(get_global_mouse_position())
	sprite2D.flip_h = (get_global_mouse_position() - global_position).x < 0
	sprite2D.flip_v = (get_global_mouse_position() - global_position).x < 0
	
	if sprite2D.flip_v:
		spawnPoint.position.y = offSetSpawnPoint * -1
	else:
		spawnPoint.position.y = offSetSpawnPoint
