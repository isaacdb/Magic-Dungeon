extends Node2D

@onready var colorRect := $CanvasLayer/ColorRect as ColorRect

var active := false

func _ready():
	pass

func _process(delta):
	if active:
		var viewportSize = get_viewport_rect().size / Global.camera.zoom
		var positionInCanvas = ((self.get_global_transform_with_canvas().origin) / Global.camera.zoom)
		
		colorRect.material.set("shader_parameter/screen_size", viewportSize)
		colorRect.material.set("shader_parameter/global_position", Vector2(positionInCanvas.x, viewportSize.y - positionInCanvas.y))


func Execute():
	active = true
	
	var tween = create_tween().set_parallel()
	tween.tween_property(colorRect.material, "shader_parameter/thickness", -0.1, 0.5).from(0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(colorRect.material, "shader_parameter/size", 0.2, 0.4).from(0.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
	
	self.reparent(get_tree().get_root().get_child(0))
	pass
