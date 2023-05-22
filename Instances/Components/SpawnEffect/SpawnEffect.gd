extends Node2D
class_name SpawnAlert
@onready var spawnAnimPlayer := $SpawnSprite/AnimationPlayer as AnimationPlayer

var objectToSpawn : PackedScene

var isSpawned := false
var isSpawning := false
var isActive := false

func _ready():
	spawnAnimPlayer.play("Spawn")

# Chamado no fim da animação
func Spawned():
	var newEnemy = objectToSpawn.instantiate() as CharacterBody2D
	self.get_parent().call_deferred("add_child", newEnemy)
	newEnemy.global_position = self.global_position
	self.queue_free()
	pass

