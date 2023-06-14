extends Node2D

@export var bossLifeBar : HealthBar
@export var defaultColorModulate : Color
@export var hitColorModulate : Color
@export var audioGameOver : AudioStreamPlayer2D
@export var audioWinGame : AudioStreamPlayer2D

@onready var deadPanel := $CanvasLayer/PanelGameOver as Panel
@onready var congrats := $CanvasLayer/PanelCongrats as Panel
@onready var canvaModulate := $CanvasModulate as CanvasModulate

var pointer = load("res://Assets/pointer4.png")

func _init():
	Global.player_dead.connect(PlayerDead)
	Global.player_hited.connect(PlayerGetHit)
	Global.boss_killed.connect(BossKilled)
	pass

func _ready():	
	Input.set_custom_mouse_cursor(pointer, Input.CURSOR_ARROW, Vector2(16, 16))
	deadPanel.position.y = -350
	deadPanel.visible = false
	
	congrats.visible = false
	congrats.position.y = -600
	
	Global.game_start.emit()
	pass


func BossKilled():	
	congrats.visible = true
	var tweenCongrats = create_tween()
	tweenCongrats.tween_interval(1)
	tweenCongrats.tween_property(congrats, "position:y", 100, 2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tweenCongrats.play()
	
	var tween = create_tween()
	tween.tween_callback(func(): get_tree().reload_current_scene()).set_delay(7)
	tween.play()
	audioWinGame.play()
	pass

func PlayerDead():
	Global.screen_shake.emit(10, 2, 1)
	audioGameOver.play()
	
	deadPanel.visible = true
	var tweenDeadPanel = create_tween()
	tweenDeadPanel.tween_property(deadPanel, "position:y", 200, 3).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN_OUT)
	tweenDeadPanel.play()
	
	var tween = create_tween()
	tween.tween_callback(func(): get_tree().change_scene_to_file("res://Levels/LevelTeste.tscn")).set_delay(7)
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
