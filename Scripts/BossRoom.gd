extends Node2D

@export var gateEnter : Gate
@export var gateExit : Gate
@export var boss : EnemyBase

@onready var areaRoom := $Area2D as Area2D
@onready var rand = RandomNumberGenerator.new()

var areaClean = false
var areaActive = false

func _ready():
	rand.randomize()
	areaRoom.connect("body_entered", area_room_body_entered)
	Global.boss_killed.connect(boss_killed)
	pass # Replace with function body.

func area_room_body_entered(body):
	if !areaClean and body.is_in_group("player"):
		areaActive = true
		gateEnter.close()
		boss.spawned()
	pass

func boss_killed():
	if areaActive and not areaClean:
		if gateExit:
			gateExit.open()
			
		gateEnter.open() 
		areaActive = false
		areaClean = true
