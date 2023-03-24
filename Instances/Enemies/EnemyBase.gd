class_name EnemyBase

extends Area2D

@export var lifeBase := 5

var currentLife := lifeBase

func _init():
	print("start eney")
	monitoring = false
	monitorable = true
	
	collision_layer = 0
	set_collision_layer_value(4, true)
	
func take_damage(damage):
	currentLife -= damage
	
	if currentLife <= 0:
		queue_free()	

