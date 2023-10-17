extends ProgressBar
class_name DashProgressBar
	
var isFull := true

func _ready():
	value = 100
	pass

func DashUsed() -> void:
	value = 0;
	isFull = false
	
	var tween = self.create_tween()
	tween.tween_property(self, "value", 100, 3)
	tween.tween_property(self, "isFull", true, 0)
	tween.play();
	pass
