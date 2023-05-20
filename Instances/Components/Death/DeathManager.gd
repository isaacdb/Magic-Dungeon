class_name DeathManager
extends Node2D

@export var switch_nps: Array[NodePath]
@onready var deathActions = switch_nps.map(get_node)  # feels hacky but works, not in editor though!

func Execute():	
	for action in deathActions:
		action.Execute()
		
	pass
