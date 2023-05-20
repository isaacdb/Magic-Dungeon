extends Area2D
class_name AttackManager

@export var playerTracker : PlayerTracker
@export var attackDelay := 0.0

@onready var timerAttack := $TimerAttack as Timer

signal attack_signal

var playerInRange := false
var attackReady := false

func _ready():
	connect("area_entered", _on_area_entered)
	connect("area_exited", _on_area_exited)
	
	timerAttack.wait_time = attackDelay
	timerAttack.timeout.connect(func(): attackReady = true)
	timerAttack.autostart = true

func _physics_process(delta):
	if playerInRange and attackReady:
		Attack()

func _on_area_entered(area):
	if area.is_in_group("player"):
		playerInRange = true
	return
	
func _on_area_exited(area):		
	if area.is_in_group("player"):
		playerInRange = false		
	return
	
func Attack():
	attackReady = false
	timerAttack.start()
	attack_signal.emit()
	pass
