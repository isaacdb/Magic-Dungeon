extends Node2D
class_name DropXp

@onready var xp := preload("res://Instances/Props/Xp/Xp.tscn")

func Execute():
	var newXp = xp.instantiate()
	get_tree().get_root().get_child(0).call_deferred("add_child", newXp)
	newXp.global_position = self.global_position
	pass