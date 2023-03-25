class_name EnemyBase

extends CharacterBody2D

@export var lifeBase := 5
@export var speed := 50
@export var damage := 1

@onready var player := get_tree().get_nodes_in_group("player")[0] as CharacterBody2D
@onready var animPlayer := $AnimationPlayer as AnimationPlayer
@onready var sprite := $Sprite2D as Sprite2D

var currentLife := 0

func _init():	
	collision_layer = 0
	
	set_collision_layer_value(4, true) # Own enemy hut box
	
	set_collision_mask_value(6, true) # Watch World	
	
func take_damage(damage, moveDirection):
	currentLife -= damage
	animPlayer.play("Hit")
	
	var tween = create_tween()
	tween.tween_property(self, "position", global_position + moveDirection * 30, 0.1).from_current()
	tween.play()
	
	if currentLife <= 0:
		queue_free()
		

