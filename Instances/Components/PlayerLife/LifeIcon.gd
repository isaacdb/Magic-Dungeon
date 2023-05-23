extends Control
class_name LifeIcon

@onready var explostion := $ExplosionParticle as CPUParticles2D
@onready var imageLife := $LifeImage as TextureRect

func _ready():
	var tween = create_tween()
	tween.tween_property(imageLife, "scale", Vector2(1, 1), 3.0).from(Vector2(0, 0)).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	pass 
	
func Destroy():
	explostion.emitting = true
	var tween = create_tween()
	tween.tween_property(imageLife, "scale", Vector2(0, 0), 2.0).from(Vector2(1, 1)).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.finished.connect(func(): queue_free())
	pass	
