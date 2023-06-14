class_name DeathComponent
extends Node2D

@onready var explosionAnimPlayer := $ExplosionSprite/AnimationPlayerExplosion as AnimationPlayer
@onready var explosionParticle := $ExplosionSprite/ExplosionParticle as CPUParticles2D
@onready var smokeParticle := $ExplosionSprite/SmokeParticle as CPUParticles2D

var isActive := true

func SetActive(active: bool):
	isActive = active
	pass

func Execute():
	if !isActive:
		return
		
	Global.emit_signal("screen_shake", 2, .2, 1)
	explosionParticle.emitting = true
	smokeParticle.emitting = true
	explosionAnimPlayer.play("Explosion")
	self.reparent(get_parent().get_parent())
	
	var tween = create_tween()
	tween.tween_callback(func(): queue_free()).set_delay(2.0)
