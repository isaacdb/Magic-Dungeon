extends ProgressBar
class_name HealthBar

func _ready():
	visible = false
	
func SetMaxValue(newMaxValue):
	max_value = newMaxValue
	pass
	
func UpdateHealthBar(newValue: float):
	visible = true
	
	var tween = create_tween()
	tween.tween_property(self, "value", newValue, 0.2).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.play()
	
	pass
