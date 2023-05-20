extends Node2D
class_name KnockBack

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func Execute(character: CharacterBody2D, force: float, direction: Vector2):
	if !isActive:
		return
	
	#character.velocity = direction * force
	#character.move_and_slide()   
	
	var tween = create_tween()
	tween.tween_property(self.get_parent(), "position", self.get_parent().global_position + direction * force, 0.1).from_current()
	tween.play()
	pass
