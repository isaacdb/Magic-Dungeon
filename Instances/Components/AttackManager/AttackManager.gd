extends Node2D
class_name AttackManager

## Não esta sendo usado no momento.
## Criei pensando em usar de uma maneira, 
## mas acabou não se encaixando na arquitetura dos inimigos
@onready var timerAttack := $TimerAttack as Timer
@onready var rnd := RandomNumberGenerator.new()

signal attack_is_ready

var attackDelay := 0.0
var attackReady := false
var isActive := false

func _ready():	
	timerAttack.timeout.connect(func(): attackReady = true)
	timerAttack.autostart = true

func SetAttackDelay(newAttackDelay: float):
	attackDelay = newAttackDelay
	timerAttack.wait_time = attackDelay
	pass
	
func _physics_process(delta):
	if !isActive:
		return
	
	if attackReady:
		Attack()

func SetActive(active: bool):
	isActive = active
	pass
	
func Attack():
	attackReady = false
	var randDelay = rnd.randf_range(0.0, 1.0)
	timerAttack.wait_time = attackDelay + randDelay	
	timerAttack.start()
	attack_is_ready.emit()
	pass
