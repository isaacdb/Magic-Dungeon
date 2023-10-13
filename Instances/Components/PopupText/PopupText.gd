extends Node2D
class_name PopupText

@onready var animatioPlayer = $AnimationPlayer as AnimationPlayer
@onready var label = $Node2D/Label as Label
@onready var node2D = $Node2D as Node2D

func SetTextAndPlay(text: String, startPosition: Vector2, height: float = 10, spread: float = 15) -> void:
	label.text = text;
	node2D.global_position = startPosition;
	
	var endPosition = Vector2(randf_range(-spread, spread), - height) + startPosition;
	var tweenTime = animatioPlayer.get_animation("Popup").length;
	
	var tween = self.create_tween();
	tween.tween_property(node2D, "global_position", endPosition, tweenTime);
	tween.play()
	
	animatioPlayer.play("Popup");
	pass
	

func DestroyItSelf():
	self.queue_free();
	pass

