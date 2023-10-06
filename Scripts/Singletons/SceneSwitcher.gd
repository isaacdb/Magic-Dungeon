extends Node

var current_scene = null
func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	pass 

func SwitchScene(path: String):
	call_deferred("DefferedSwitchScene", path)
	pass

func DefferedSwitchScene(path: String):
	current_scene.free()
	var newScene = load(path)
	current_scene = newScene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene
	pass
