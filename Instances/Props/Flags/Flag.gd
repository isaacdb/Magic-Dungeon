extends Node2D

@onready var areaCollision := $Area2D as Area2D
@onready var sprite := $Sprite2D as Sprite2D
@onready var rnd := RandomNumberGenerator.new()

func _ready():
	areaCollision.area_entered.connect(PlayerContact)
	rnd.randomize()
	sprite.frame = rnd.randi_range(0, sprite.hframes - 1)
	pass


func PlayerContact(area):
	var tween = create_tween()
	tween.tween_property(sprite.material, "shader_parameter/dis", 3, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite.material, "shader_parameter/dis", 0, 1).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_IN)
	tween.play()
	pass
