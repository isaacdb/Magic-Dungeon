extends Node2D
class_name DropXp

@onready var xp := preload("res://Instances/Props/Xp/Xp.tscn")

@export var xpAmount := 1;
@export_range(0, 100) var dropChance : int = 100;

var rand := RandomNumberGenerator.new()

func _ready() -> void:
	rand.randomize();
	pass

func Execute() -> void:
	var randDropChance = rand.randi_range(0, 100)
	var dropChanceOk = randDropChance >= 100 - dropChance;
	
	if not dropChanceOk:
		return
	
	for xpUnid in xpAmount:
		var newXp = xp.instantiate()
		get_tree().get_root().get_child(0).call_deferred("add_child", newXp)
		newXp.global_position = self.global_position
	
	pass
