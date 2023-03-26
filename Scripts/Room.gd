extends Node2D

@onready var areaRoom := $Area2D as Area2D
@export var gateEnter : Gate

var areaClean = false

func _ready():
	areaRoom.connect("body_entered", area_room_body_entered)
	pass # Replace with function body.


func area_room_body_entered(body):
	if !areaClean and body.is_in_group("player"):
		areaClean = true
		gateEnter.close()
	pass
