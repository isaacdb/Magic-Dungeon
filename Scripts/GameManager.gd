extends Node2D

@export var bossLifeBar : HealthBar
@export var defaultColorModulate : Color
@export var hitColorModulate : Color

@onready var deadPanelAnim := $CanvasLayer/DeadPanel/AnimationPlayer as AnimationPlayer
@onready var timerDead := $CanvasLayer/DeadPanel/TimerDead as Timer
@onready var canvaModulate := $CanvasModulate as CanvasModulate

var pointer = load("res://Assets/pointer4.png")

func _init():
	Global.player_dead.connect(player_dead)
#	Global.update_player_life.connect(UpdatePlayerLife)
	Global.player_hited.connect(PlayerGetHit)
	pass

func _ready():	
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(16, 16))
	pass

func player_dead():
	deadPanelAnim.play("Dead")
	timerDead.start()
	
	pass

func _on_timer_dead_timeout():
	get_tree().reload_current_scene()
	pass

#func UpdatePlayerLife(currentLife: float):
#	#playerLifeBar.UpdateHealthBar(currentLife)
#	pass
	
func PlayerGetHit():
	var tween = create_tween()
	tween.tween_property(canvaModulate, "color", hitColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(canvaModulate, "color", defaultColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(canvaModulate, "color", hitColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(canvaModulate, "color", defaultColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	pass
