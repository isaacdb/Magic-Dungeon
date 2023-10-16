extends Panel

@onready var audioWinGame = %AudioWinGame as AudioStreamPlayer2D

func _ready():
	Global.boss_killed.connect(CongratsPanelActive)
	visible = false
	pass
	
func CongratsPanelActive() -> void:
	visible = true
	
	if Settings.soundEffect:
		audioWinGame.play();
		
	var tweenCongrats = create_tween()
	tweenCongrats.tween_interval(1)
	tweenCongrats.tween_property(self, "position:y", 182, 2)\
				.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT).from(-235)
	tweenCongrats.play()
	pass
