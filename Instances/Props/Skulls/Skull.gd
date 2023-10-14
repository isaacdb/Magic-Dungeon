extends StaticBody2D

@onready var sprite := $Sprite2D as Sprite2D
@onready var rnd := RandomNumberGenerator.new()
@onready var area_2d = $Area2D as Area2D

var forceApplied := 0.0
var direction : Vector2
var velocity : Vector2

func _ready() -> void:
	rnd.randomize()
	sprite.rotation_degrees = rnd.randi_range(0, 360)
	area_2d.body_entered.connect(Shake)
	area_2d.area_entered.connect(Shake)
	pass
	
func _physics_process(delta) -> void:
	if forceApplied > 0 and direction != Vector2.ZERO:
		velocity = forceApplied * direction * delta
		move_and_collide(velocity)
		forceApplied -= delta * 30
		sprite.rotation += delta * (forceApplied / 3) * direction.x
	pass
	
func Shake(body) -> void:
	forceApplied = 60.0
	direction = Vector2(rnd.randf_range(-1, 1), rnd.randf_range(-1, 1))
	pass
