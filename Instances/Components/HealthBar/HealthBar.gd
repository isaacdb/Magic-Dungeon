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
	tween.tween_property(self, "value", newValue, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()
	
	pass
