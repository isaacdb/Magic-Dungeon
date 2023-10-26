extends Node2D
class_name AttackManager

signal attack_manager_finished

func Execute():
	var indexRandPatern = randi_range(0, get_child_count() - 1)
	var randAttackPatern = get_children()[indexRandPatern]
	randAttackPatern.Execute()
	pass
	
# Called by patterns when they finished
func AttackCompleted():
	attack_manager_finished.emit()
	pass
