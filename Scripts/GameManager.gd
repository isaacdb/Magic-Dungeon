extends Node2D

@export var bossLifeBar : HealthBar
@export var defaultColorModulate : Color
@export var hitColorModulate : Color

@onready var deadPanel := $CanvasLayer/DeadPanel as ColorRect
@onready var congrats := $CanvasLayer/CongratsPanel as ColorRect
@onready var canvaModulate := $CanvasModulate as CanvasModulate

var pointer = load("res://Assets/pointer4.png")

func _init():
	Global.player_dead.connect(PlayerDead)
	Global.player_hited.connect(PlayerGetHit)
	Global.boss_killed.connect(BossKilled)
	pass

func _ready():	
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(16, 16))
	deadPanel.modulate = Color(1, 1, 1, 0)
	deadPanel.visible = false
	
	congrats.modulate = Color(1, 1, 1, 0)
	congrats.visible = false
	pass


func BossKilled():	
	congrats.visible = true
	var tweenCongrats = create_tween()
	tweenCongrats.tween_property(congrats, "modulate", Color(1, 1, 1, 1), 3)
	tweenCongrats.play()
	
	var tween = create_tween()
	tween.tween_callback(func(): get_tree().reload_current_scene()).set_delay(7)
	tween.play()
	pass

func PlayerDead():
	Global.screen_shake.emit(10, 2, 1)
	
	deadPanel.visible = true
	var tweenDeadPanel = create_tween()
	tweenDeadPanel.tween_property(deadPanel, "modulate", Color(1, 1, 1, 1), 3)
	tweenDeadPanel.play()
	
	var tween = create_tween()
	tween.tween_callback(func(): get_tree().reload_current_scene()).set_delay(7)
	tween.play()
	pass

func PlayerGetHit():
	var tween = create_tween()
	tween.tween_property(canvaModulate, "color", hitColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(canvaModulate, "color", defaultColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(canvaModulate, "color", hitColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(canvaModulate, "color", defaultColorModulate, 0.1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.play()
	
	var tweenTime = create_tween()
	tweenTime.tween_property(Engine, "time_scale", 0.3, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tweenTime.tween_property(Engine, "time_scale", 1.0, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)	
	tweenTime.play()
	
	
	pass
