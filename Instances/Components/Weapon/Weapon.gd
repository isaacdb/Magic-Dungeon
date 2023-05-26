extends Node2D
class_name Weapon

@onready var sprite := $Sprite2D as Sprite2D
@onready var noise := FastNoiseLite.new()
@onready var rnd = RandomNumberGenerator.new()

var noise_i : float
var noise_speed : float = 1.0
var noise_strength : float = 8.0

var currentPos : Vector2

func _ready():
	rnd.randomize()
	noise.seed = rnd.randi()

func _physics_process(delta):
	sprite.position.y = Global.CalculeFloatVariation(delta, 0.15, 1.5)
	pass
	
# funcionou, porem não ficou mt bom usando na arma
# pra arma fica melhor um float mais estavel mesmo.	
func GetNoise(delta) -> Vector2:
	noise_i += delta * noise_speed
	
	return Vector2(
		noise.get_noise_2d(20, noise_i) * noise_strength,
		noise.get_noise_2d(20, noise_i) * noise_strength
	)
	

func PlayAnimFire():
	var tween = create_tween()
	tween.tween_property(sprite, "position:x", -5, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position:x", 0, 0.3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.play()
	
