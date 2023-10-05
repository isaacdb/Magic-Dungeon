extends Node2D


@export var lifeBase := 3
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
	var direction = (self.global_position - attack.direction).normalized()
	
	var tweenRot = create_tween()
	tweenRot.tween_property(self, "rotation_degrees", direction.x * 25, 0.3).set_trans(Tween.TRANS_QUART).set_ease(Tween.EASE_OUT)
	tweenRot.tween_property(self, "rotation_degrees", 0, 1.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)	
	tweenRot.play()
	pass
