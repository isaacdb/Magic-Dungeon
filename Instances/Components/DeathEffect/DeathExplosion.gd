class_name DeathComponent
extends Node2D

@onready var explosionAnimPlayer := $ExplosionSprite/AnimationPlayerExplosion as AnimationPlayer

func Execute():
	Global.emit_signal("screen_shake", 2, .2, .5)
	Global.emit_signal("enemy_killed")
	explosionAnimPlayer.play("Explosion")
	explosionAnimPlayer.get_parent().reparent(get_tree().get_root())
	get_parent().queue_free()
