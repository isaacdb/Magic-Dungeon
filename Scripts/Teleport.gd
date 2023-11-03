extends Area2D

@export var destinyScenePath : String

var teleportUsed := false;

func _ready() -> void:
	area_entered.connect(OnAreaEntered)
	pass
	
func OnAreaEntered(area: Area2D) -> void:	
	if teleportUsed:
		return;
		
	if area.is_in_group("player"):
		teleportUsed = true;
		if destinyScenePath:
			get_tree().change_scene_to_file(destinyScenePath)
		else:
			ProgressManager2.LoadNewRoom()
	pass
