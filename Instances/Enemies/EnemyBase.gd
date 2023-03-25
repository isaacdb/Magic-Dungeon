class_name EnemyBase

extends Area2D

@export var lifeBase := 5
@export var speed := 50
@export var damage := 1

@onready var player := get_tree().get_nodes_in_group("player")[0] as CharacterBody2D
@onready var animPlayer := $AnimationPlayer as AnimationPlayer

var currentLife := lifeBase

func _init():
	monitoring = true
	monitorable = true
	
	collision_layer = 0
	set_collision_layer_value(4, true) # Own enemy hut box
	
	set_collision_mask_value(6, true) # Watch World	
	
func take_damage(damage):
	currentLife -= damage
	animPlayer.play("Hit")
	
	if currentLife <= 0:
		queue_free()	

