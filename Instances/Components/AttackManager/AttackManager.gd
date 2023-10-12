extends Node2D
class_name AttackManager

@export var pathsAttackPaterns: Array[NodePath]
@onready var attackPaterns = pathsAttackPaterns.map(get_node)  # feels hacky but works, not in editor though!

@onready var rnd := RandomNumberGenerator.new()

var attackIsRunning := false

func _ready():	
	rnd.randomize()

func Execute():
	attackIsRunning = true
	var indexRandPatern = rnd.randi_range(0, attackPaterns.size() -1)
	var randAttackPatern = attackPaterns[indexRandPatern]
	randAttackPatern.Execute()
	pass
	
# Called by patterns when they finished
func AttackCompleted():
	attackIsRunning = false
	pass
