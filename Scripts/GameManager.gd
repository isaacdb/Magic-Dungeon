extends Node2D

@export var playerLifeBar : HealthBar

@onready var deadPanelAnim := $CanvasLayer/DeadPanel/AnimationPlayer as AnimationPlayer
@onready var timerDead := $CanvasLayer/DeadPanel/TimerDead as Timer


func _init():
	Global.player_dead.connect(player_dead)
	Global.set_player_max_life.connect(SetPlayerLife)
	Global.update_player_life.connect(UpdatePlayerLife)
	pass

func _ready():
	pass

func player_dead():
	deadPanelAnim.play("Dead")
	timerDead.start()
	pass

func _on_timer_dead_timeout():
	get_tree().reload_current_scene()
	pass

func UpdatePlayerLife(currentLife: float):
	playerLifeBar.UpdateHealthBar(currentLife)
	pass
	
func SetPlayerLife(maxLife: float):
	playerLifeBar.SetMaxValue(maxLife)
	pass
