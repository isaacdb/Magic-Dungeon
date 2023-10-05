extends Node2D

@export var lifeBase := 8
@export var dropXpOn := true

@onready var healthManager := $Health as Health
@onready var dropXp := $DropXp as DropXp
@onready var sprite := $Sprite2D as Sprite2D
@onready var rnd := RandomNumberGenerator.new()

func _ready():
	rnd.randomize()
	sprite.frame = rnd.randi_range(0, (sprite.hframes * sprite.vframes) - 1)

	healthManager.SetLifeBase(lifeBase)
	healthManager.damage.connect(Shake)
	
	if not dropXpOn:
		dropXp.dropChance = 0	
	pass
	
func Shake(attack: Attack):	
	var dir =  1 if randf() > 0.5 else -1
	
	var tweenRot = create_tween().set_loops(3)
	tweenRot.tween_property(sprite, "position", Vector2(randf() * dir, randf() * (-dir)) , 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tweenRot.tween_property(sprite, "position", Vector2.ZERO, 0.05).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tweenRot.play()
	pass
