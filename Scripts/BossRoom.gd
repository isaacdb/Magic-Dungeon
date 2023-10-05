extends Node2D

@export var gateExit : Gate
@export var boss : PackedScene
@export var spawnAlert : PackedScene
@export var audioPlayer : AudioStreamPlayer2D
@export var spawnPoint : Node2D

@onready var rand = RandomNumberGenerator.new()

func _ready():
	rand.randomize()
	Global.boss_killed.connect(boss_killed)
	Global.enter_boss_room.emit()
	SpawnBoss()
	pass
	
func SpawnBoss() -> void:
	var newSpawn = spawnAlert.instantiate() as SpawnAlert
	self.call_deferred("add_child", newSpawn)
	newSpawn.objectToSpawn = boss
	newSpawn.global_position = spawnPoint.global_position
	pass

func boss_killed() -> void:
	if gateExit:
		gateExit.open()
