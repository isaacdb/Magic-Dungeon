extends Node2D
class_name SpawnAlert

@onready var spawnAnimPlayer := $SpawnSprite/AnimationPlayer as AnimationPlayer
@onready var sprite := $SpawnSprite as AnimatedSprite2D

var objectToSpawn : PackedScene

var isSpawned := false
var isSpawning := false
var isActive := false

func _ready():
	spawnAnimPlayer.play("SpawnAlert")
	var tween = create_tween()
	tween.tween_property(sprite, "rotation_degrees", 0.0, 1.0).from(10.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "rotation_degrees", 0.0, 1.0).from(10.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "rotation_degrees", 0.0, 1.0).from(10.0).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)	
	

# Chamado no fim da animação
func Spawned():
	var newEnemy = objectToSpawn.instantiate() as CharacterBody2D
	self.get_parent().call_deferred("add_child", newEnemy)
	newEnemy.global_position = self.global_position
	self.queue_free()
	pass

