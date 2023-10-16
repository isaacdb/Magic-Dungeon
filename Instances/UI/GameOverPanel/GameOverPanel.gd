extends Panel

@onready var audioGameOver = %AudioGameOver as AudioStreamPlayer2D

func _ready():
	Global.player_dead.connect(GameOverPanelActive)
	visible = false
	pass

func GameOverPanelActive() -> void:
	if Settings.soundEffect:
		audioGameOver.play();
	
	visible = true
	var tweenDeadPanel = create_tween()
	tweenDeadPanel.tween_property(self, "position:y", 182, 3)\
				.set_trans(Tween.TRANS_BACK)\
				.set_ease(Tween.EASE_IN_OUT).from(-435)
	tweenDeadPanel.play()
	pass
