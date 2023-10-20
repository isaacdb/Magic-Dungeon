extends Node2D
class_name FlashHit

signal end_flash_damage

@export var sprite : Sprite2D
@export var animatedSprite : AnimatedSprite2D

var materialSprite : Material

func _ready():
	if sprite:
		materialSprite = sprite.material
	elif animatedSprite:
		materialSprite = animatedSprite.material

func Flash():
	if not materialSprite:
		return;
	
	var tween = create_tween()
	tween.set_loops(2)
	tween.tween_property(materialSprite, "shader_parameter/flash_modifier", 1.0, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(materialSprite, "shader_parameter/flash_modifier", 0.0, 0.1).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func(): end_flash_damage.emit())
	pass
	
func IFrameFlahsing(iFrameSeconds: float) -> void:
	if not materialSprite:
		return;
	
	var tween = create_tween()
	tween.set_loops(round(iFrameSeconds / 0.5))
	tween.tween_property(materialSprite, "shader_parameter/flash_modifier", 0.7, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property(materialSprite, "shader_parameter/flash_modifier", 0.0, 0.25).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	pass
