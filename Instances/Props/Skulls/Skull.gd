extends StaticBody2D

@export var healthManager : Health

@export var lifeBase := 3

@onready var sprite := $Sprite2D as Sprite2D
@onready var rnd := RandomNumberGenerator.new()

var forceApplied := 0.0
var direction := Vector2.ZERO
var velocity := Vector2.ZERO

func _ready():
	rnd.randomize()
	healthManager.SetLifeBase(lifeBase)
	healthManager.damage.connect(Shake)
	pass
	
func _physics_process(delta):
	velocity = forceApplied * direction * delta
	move_and_collide(velocity)
	sprite.rotation += delta * (forceApplied / 3) * direction.x
	pass
	
func Shake(attack: Attack):
	direction = (self.global_position - attack.direction).normalized()
	forceApplied = 60.0
	
	var tween = create_tween()
	tween.tween_property(self, "forceApplied", 0, 1.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	tween.play()
	pass
