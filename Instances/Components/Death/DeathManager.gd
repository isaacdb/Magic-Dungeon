class_name DeathManager
extends Node2D

@export var deathAudio : AudioStream
@onready var audioPlayer := $AudioStreamPlayer2D as AudioStreamPlayer2D

func _ready():
	if deathAudio:
		audioPlayer.stream = deathAudio
	pass

func Execute():	
	for action in get_children():
		if action.has_method("Execute"):
			action.Execute();
	
	if deathAudio:
		audioPlayer.play()
		audioPlayer.reparent(get_parent().get_parent())
		var tween = create_tween()
		tween.tween_callback(func(): audioPlayer.queue_free()).set_delay(2.0)
	
	get_parent().queue_free()
	pass
