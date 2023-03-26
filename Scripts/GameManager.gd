extends Node2D

@onready var deadPanelAnim := $CanvasLayer/DeadPanel/AnimationPlayer as AnimationPlayer
@onready var timerDead := $CanvasLayer/DeadPanel/TimerDead as Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.player_dead.connect(player_dead)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func player_dead():
	deadPanelAnim.play("Dead")
	timerDead.start()
	pass

func _on_timer_dead_timeout():
	get_tree().reload_current_scene()
	pass
