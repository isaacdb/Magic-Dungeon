extends Node2D

@export var player : Mage1

@export var bossRommTp : Marker2D

func _physics_process(delta):	
	if Input.is_action_pressed("ui_text_backspace"):
#		player.global_position = bossRommTp.global_position
		pass
			
	if Input.is_action_just_pressed("ui_home"):
		Global.level_up.emit()

#	if Input.is_action_just_pressed("ui_end"):
#		Global.boss_killed.emit()

