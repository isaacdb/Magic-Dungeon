extends Node2D

@export var gateEnter : Gate
@export var gateExit : Gate
@export var enemies : Array[PackedScene]

@onready var areaRoom := $Area2D as Area2D
@onready var spawnPoints = self.get_node("SpawnPoints").get_children() as Array[Node2D]
@onready var rand = RandomNumberGenerator.new()

var areaClean = false

func _ready():
	rand.randomize()
	areaRoom.connect("body_entered", area_room_body_entered)
	pass # Replace with function body.

func area_room_body_entered(body):
	if !areaClean and body.is_in_group("player"):
		areaClean = true
		gateEnter.close()
		spawn_enemies()
	pass
	
func spawn_enemies():
	for enemy in enemies:
		var newEnemy = enemy.instantiate() as CharacterBody2D
		get_tree().root.call_deferred("add_child", newEnemy)
		var positionIndex = rand.randi_range(0, spawnPoints.size() - 1)		
		newEnemy.global_position = spawnPoints[positionIndex].global_position
	pass
