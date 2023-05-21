class_name Gate

extends StaticBody2D

@onready var animPlayer := $AnimationPlayer as AnimationPlayer

func close():
	Global.emit_signal("screen_shake", 2, 1, 1)
	animPlayer.play("Close")
	
func open():
	Global.emit_signal("screen_shake", 2, 1, 1)
	animPlayer.play("Open")