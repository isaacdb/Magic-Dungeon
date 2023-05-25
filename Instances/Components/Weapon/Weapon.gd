extends Node2D
class_name Weapon

@onready var animationPlayer := $AnimationPlayer as AnimationPlayer

func PlayAnimFire():
	animationPlayer.play("Fired")
