extends Camera2D

var startShake = false
var shakeIntesity = 0.0
var shakeDampening = 0.0

@onready var shakeTimer := $ShakeTimer as Timer

func _ready():
	Global.screen_shake.connect(screen_shake)
	pass
	
func _process(delta):
	if startShake:
		offset.x = randf_range(-1, 1) * shakeIntesity
		offset.y = randf_range(-1, 1) * shakeIntesity		
	else:
		offset = Vector2.ZERO
	pass
	
func screen_shake(intensity, duration, dampening):
	# Tratativa para prevalecer a maior intensidade quando dois sinais disparados ao msm tempo
	if startShake and intensity < shakeIntesity:
		return	
	
	shakeIntesity = intensity
	shakeTimer.wait_time = duration
	shakeTimer.start()
	shakeDampening = dampening
	startShake = true
	
	pass

func _on_shake_timer_timeout():
	startShake = false
	pass
