class_name DeathManager
extends Node2D

@export var activeHandle : ActiveHandleComponent

@export var switch_nps: Array[NodePath]
@onready var deathActions = switch_nps.map(get_node)  # feels hacky but works, not in editor though!

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func Execute():	
	if !isActive:
		return
	
	for action in deathActions:
		action.Execute()
		action.reparent(get_tree().get_root())
	
	Global.emit_signal("enemy_killed")
	
	activeHandle.Execute(false)
	get_parent().queue_free()
	pass
