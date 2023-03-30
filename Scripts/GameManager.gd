extends Node2D

@onready var deadPanelAnim := $CanvasLayer/DeadPanel/AnimationPlayer as AnimationPlayer
@onready var timerDead := $CanvasLayer/DeadPanel/TimerDead as Timer

func _ready():
	Global.player_dead.connect(player_dead)
	pass # Replace with function body.


func _process(delta):
	pass


func player_dead():
	deadPanelAnim.play("Dead")
	timerDead.start()
	pass

func _on_timer_dead_timeout():
	get_tree().reload_current_scene()
	pass
