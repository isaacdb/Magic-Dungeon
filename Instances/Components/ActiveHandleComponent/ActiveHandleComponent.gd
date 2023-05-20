extends Node2D
class_name ActiveHandleComponent

@export var activeOnLoad := false

@export var switch_nps: Array[NodePath]
@onready var listOfComponents = switch_nps.map(get_node)  # feels hacky but works, not in editor though!

func _ready():
	if activeOnLoad:
		Execute(true)

func Execute(active: bool):
	for component in listOfComponents:
		component.SetActive(active)		
		
	pass	
