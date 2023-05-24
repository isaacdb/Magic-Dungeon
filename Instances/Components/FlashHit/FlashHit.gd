extends Node2D
class_name FlashHit

func Flash(material: Material):
	var tween = create_tween()
	tween.set_loops(3)
	tween.tween_property(material, "shader_parameter/flash_modifier", 1.0, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(material, "shader_parameter/flash_modifier", 0.0, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	pass
