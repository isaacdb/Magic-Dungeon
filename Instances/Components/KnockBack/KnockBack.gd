extends Node2D
class_name KnockBack

@onready var timerKnock := $Timer as Timer

var isActive := false
var isKnocking := false
var characterKnock : CharacterBody2D
var forceKnock : float
var impactOriginKnock : Vector2


func _ready():
	timerKnock.wait_time = 0.1
	timerKnock.autostart = false
	timerKnock.one_shot = true
	timerKnock.timeout.connect(TimerKnockBackTimeout)

func SetActive(active: bool):
	isActive = active
	pass

func _physics_process(delta):
	if isKnocking and isActive:
		var direction = (self.global_position - impactOriginKnock).normalized()	
		characterKnock.velocity = direction * forceKnock
		characterKnock.move_and_slide()
	pass


func Execute(character: CharacterBody2D, force: float, impactOrigin: Vector2):
	if !isActive:
		return
	
	isKnocking = true
	characterKnock = character
	forceKnock = force
	impactOriginKnock = impactOrigin
	timerKnock.start()

#	var direction = (self.global_position - impactOrigin).normalized()	
#	var tween = create_tween()
#	tween.tween_property(self.get_parent(), "position", self.get_parent().global_position + direction * force, 0.1).from_current()
#	tween.play()
	pass
	
func TimerKnockBackTimeout():
	isKnocking = false
	pass	
