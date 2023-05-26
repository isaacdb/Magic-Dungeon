extends Camera2D

var startShake = false
var shakeIntesity = 0.0
var shakeDampening = 0.0

@onready var shakeTimer := $ShakeTimer as Timer
@onready var playerTracker := $PlayerTracker as PlayerTracker

var isPlayerLive := true

func _ready():
	Global.screen_shake.connect(screen_shake)
	Global.player_dead.connect(ZoomPlayerDead)
	Global.camera = self
	SetFirstPosition()
	pass

func SetFirstPosition():
	position_smoothing_enabled = false
	global_position = playerTracker.GetPosition()
	position_smoothing_enabled = true	
	pass
	
func _process(delta):
	var offSetAimShoot := Vector2.ZERO
	
	if isPlayerLive:
		global_position = playerTracker.GetPosition()
	
		var projectResolution = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))
		var resolutionCamera = Vector2(projectResolution.x / zoom.x, projectResolution.y / zoom.y)
		var mousePous = get_global_mouse_position()
		
		offSetAimShoot.x = (mousePous.x - self.global_position.x) / (resolutionCamera.x / 2.0) * 10.0
		offSetAimShoot.y = (mousePous.y - self.global_position.y) / (resolutionCamera.y / 2.0) * 10.0
	
	if startShake:
		offset.x = offSetAimShoot.x + (randf_range(-1, 1) * shakeIntesity)
		offset.y = offSetAimShoot.y + (randf_range(-1, 1) * shakeIntesity)
	else:
		offset.x = offSetAimShoot.x
		offset.y = offSetAimShoot.y
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
	
func ZoomPlayerDead():
	isPlayerLive = false
	var tween = create_tween()
	tween.tween_property(self, "zoom", Vector2(6 , 6), 5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)	
	tween.play()
	pass
