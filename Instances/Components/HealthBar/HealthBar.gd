extends ProgressBar
class_name HealthBar

func _ready():
	visible = false
	
func SetMaxValue(newMaxValue):
	max_value = newMaxValue
	pass
	
func UpdateHealthBar(newValue: float):
	visible = true
	value = newValue
	pass

