extends Node2D

@export var healthManager : Health

func _ready():
	healthManager.damage.connect(Shake)
	pass
	
func Shake(attack: Attack):
	var direction = (self.global_position - attack.direction).normalized()
	
	var tweenRot = create_tween()
	tweenRot.tween_property(self, "rotation_degrees", direction.x * 25, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tweenRot.tween_property(self, "rotation_degrees", 0, 1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)	
	tweenRot.play()
	pass
