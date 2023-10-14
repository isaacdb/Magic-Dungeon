extends Area2D


@onready var sprite := $Sprite2D as Sprite2D
@onready var rnd := RandomNumberGenerator.new()

func _ready():
	rnd.randomize()
	sprite.frame = rnd.randi_range(0, (sprite.hframes * sprite.vframes) - 1)
	
	area_entered.connect(Shake);
	body_entered.connect(Shake);	
	pass
	
func Shake(body) -> void:
	var dir =  1 if randf() > 0.5 else -1
	var tweenRot = create_tween().set_loops(3)
	tweenRot.tween_property(sprite, "position", Vector2(randf() * dir, randf() * (-dir)) , 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tweenRot.tween_property(sprite, "position", Vector2.ZERO, 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tweenRot.play()
	pass
