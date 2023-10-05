class_name DeathManager
extends Node2D

@export var activeHandle : ActiveHandleComponent
@export var deathAudio : AudioStream

@export var switch_nps: Array[NodePath]
@onready var deathActions = switch_nps.map(get_node)  # feels hacky but works, not in editor though!
@onready var audioPlayer := $AudioStreamPlayer2D as AudioStreamPlayer2D


var isActive := true

func _ready():
	if deathAudio:
		audioPlayer.stream = deathAudio
	pass

func SetActive(active: bool):
	isActive = active
	pass

func Execute():
	if !isActive:
		return
	
	for action in deathActions:
		action.Execute()
	
	if activeHandle:
		activeHandle.Execute(false)
	
	if deathAudio && Settings.soundEffect:
		audioPlayer.play()
		audioPlayer.reparent(get_parent().get_parent())
		var tween = create_tween()
		tween.tween_callback(func(): audioPlayer.queue_free()).set_delay(2.0)
	
	get_parent().queue_free()
	pass
