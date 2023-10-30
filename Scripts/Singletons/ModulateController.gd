extends Node

@export var modulate_color : Color = Color(0.455, 0.447, 0.725)

func _ready():
	get_tree().node_added.connect(apply_modulate)
	
	var nodes_to_modulate = get_tree().get_nodes_in_group("have_modulate")
	for node in nodes_to_modulate:
		apply_modulate(node);

func apply_modulate(node) -> void:
	if not node.is_in_group("have_modulate"):
		return
	
	node.self_modulate = modulate_color
	pass
