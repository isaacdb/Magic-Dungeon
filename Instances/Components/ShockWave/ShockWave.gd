extends Node2D

@onready var colorRect := $CanvasLayer/ColorRect as ColorRect

var active := false

func _ready():
	colorRect.visible = false
	pass

func _process(delta):
	## Quando ativo, reposiciona a imagem de distorção com base na camera e movimentação do player
	## Isso pq a distorição fica 'fixa' na tela, e não na posição global.
	if active:
		var viewportSize = get_viewport_rect().size / Global.camera.zoom
		var positionInCanvas = ((self.get_global_transform_with_canvas().origin) / Global.camera.zoom)
		
		colorRect.material.set("shader_parameter/screen_size", viewportSize)
		colorRect.material.set("shader_parameter/global_position", Vector2(positionInCanvas.x, viewportSize.y - positionInCanvas.y))


func Execute():
	active = true
	colorRect.visible = true
	
	var tween = create_tween().set_parallel()
	tween.tween_property(colorRect.material, "shader_parameter/thickness", -0.1, 0.5).from(0.1).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property(colorRect.material, "shader_parameter/size", 0.2, 0.4).from(0.0).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.play()
	
	self.reparent(get_tree().get_first_node_in_group("Room"))
	get_tree().create_timer(2).timeout.connect(func(): queue_free())
	pass
