class_name DeathComponent
extends Node2D

@onready var explosionAnimPlayer := $ExplosionSprite/AnimationPlayerExplosion as AnimationPlayer
@onready var explosionParticle := $ExplosionSprite/ExplosionParticle as CPUParticles2D

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func Execute():
	if !isActive:
		return
		
	Global.emit_signal("screen_shake", 2, .2, 1)
	explosionParticle.emitting = true
	explosionAnimPlayer.play("Explosion")
