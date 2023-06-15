extends Node2D

func _physics_process(delta):	
	if Input.is_action_pressed("ui_text_backspace"):
		Global.level_up.emit()
	
#
#	if Input.is_action_just_pressed("dash"):
#		Global.level_up.emit()a

