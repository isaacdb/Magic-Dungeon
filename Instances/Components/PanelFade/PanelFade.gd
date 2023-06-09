extends ColorRect

func _ready():
	Global.player_dead.connect(FadeOut)
	
	visible = true	
	modulate = Color(0, 0, 0, 1)
	
	FadeIn()
	
	pass
	
func FadeIn():
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0, 0, 0, 0), 1)
	tween.tween_property(self, "visible", false, 0)
	tween.play()
	
func FadeOut():
	visible = true
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(0, 0, 0, 1), 6).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
	tween.play()
