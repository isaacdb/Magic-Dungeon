class_name Gate

extends StaticBody2D

@onready var animPlayer := $AnimationPlayer as AnimationPlayer

func close():
	animPlayer.play("Close")
