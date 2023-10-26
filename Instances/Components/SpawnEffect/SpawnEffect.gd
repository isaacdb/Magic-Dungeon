extends Node2D
class_name SpawnAlert

@onready var sprite := $SpawnSprite as AnimatedSprite2D

var objectToSpawn : PackedScene

var isSpawned := false
var isSpawning := false

func _ready():
	var tween = create_tween()
	tween.tween_property(sprite, "rotation_degrees", 10.0, 1.0).from(10.0)#.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "rotation_degrees", -10.0, 1.0)#.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "rotation_degrees", 10.0, 1.0)#.set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(sprite, "scale", Vector2(0, 0), 1.0)
	tween.tween_callback(Spawned)
	tween.play();
	
	var tween_scale = create_tween()
	tween_scale.set_loops(2)
	tween_scale.tween_property(sprite, "scale", Vector2(1, 1), 0.5).from(Vector2(1.2, 1.2))
	tween_scale.tween_property(sprite, "scale", Vector2(1.2, 1.2), 0.5)
	tween_scale.play()	
# Chamado no fim da animação
func Spawned():
	var newEnemy = objectToSpawn.instantiate() as CharacterBody2D
	self.get_parent().call_deferred("add_child", newEnemy)
	newEnemy.global_position = self.global_position
	self.queue_free()
	pass

