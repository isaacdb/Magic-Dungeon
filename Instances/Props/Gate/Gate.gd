extends StaticBody2D
class_name Gate

@export var startOpen := false

@onready var animPlayer := $AnimationPlayer as AnimationPlayer

func _ready():
	if startOpen:
		open()

func close():
	Global.emit_signal("screen_shake", 2, 1, 1)
	animPlayer.play("Close")
	
func open():
	Global.emit_signal("screen_shake", 2, 1, 1)
	animPlayer.play("Open")
