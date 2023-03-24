extends Area2D

@export var speed := 600.0
@export var moveDirection := Vector2.ZERO
@export var damage := 0.0
@export_enum("None:-1", "Player:0", "Enemy:1") var origin = "Player"

var velocity := Vector2.ZERO

func _ready():
	
	set_collision_mask_value(6, true) # World collision
	match origin:
		"None":
			print("Bullet origin is MISSING!!")
		"Player":
			set_collision_mask_value(4, true) #Collision with enemy hurtBox
		"Enemy":
			set_collision_mask_value(2, true) #Collision with player hurtBox			
	
	monitoring = true
	monitorable = true # Have to be true, just bc a bug, its required for collision with tileemap
	
	connect("body_entered", _on_body_entered)
	connect("area_entered", _on_area_entered)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = speed * moveDirection * delta	
	translate(velocity)
	pass
	
func _on_body_entered(body):
	if body.has_method("take_damage"):
		body.take_damage(damage)
		
	_destroy()
	pass

func _on_area_entered(area):
	if area.has_method("take_damage"):
		area.take_damage(damage)
		
	_destroy()
	pass
	
func _destroy():
	self.queue_free()
	pass


