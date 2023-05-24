extends Area2D

@export var playerTracker : PlayerTracker

@onready var default_pos = self.global_position

var amplitude := 0.3
var frequency := 2.0
var speed := 5.0

var moveToPlayer := false

func _ready():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "scale", Vector2(1.2, 1.2), 1.0)
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 1.0)
	
	var tweenRotate = create_tween().set_loops()
	tweenRotate.tween_property(self, "rotation_degrees", 360, 3.0).from(0.0)
	
	area_entered.connect(on_area_entered)
	pass


func _physics_process(delta):		
	if moveToPlayer:
		if playerTracker.GetDistance() < 5.0:
			Collected()
			return 
			
		var velocity := Vector2.ZERO
		speed += 0.5
		velocity = speed * playerTracker.GetDirection() * delta * playerTracker.GetDistance()
		translate(velocity)
	else:
		global_position.y = default_pos.y + (sin(Time.get_ticks_msec() * delta * amplitude) * frequency)
	
	pass
	
func Collected():
	Global.xp_colleted.emit()
	queue_free()
	pass
	
func PlayerIsNear():
	moveToPlayer = true
	pass
	
func on_area_entered(area):
	if area.is_in_group("player"):
		PlayerIsNear()
	pass
