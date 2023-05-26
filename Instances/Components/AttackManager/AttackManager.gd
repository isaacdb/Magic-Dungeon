extends Node2D
class_name AttackManager

@export var pathsAttackPaterns: Array[NodePath]
@onready var attackPaterns = pathsAttackPaterns.map(get_node)  # feels hacky but works, not in editor though!

@onready var rnd := RandomNumberGenerator.new()

func _ready():	
	rnd.randomize()

func Execute():
	var indexRandPatern = rnd.randi_range(0, attackPaterns.size() -1)	
	var randAttackPatern = attackPaterns[indexRandPatern]
	randAttackPatern.Execute()
	pass
