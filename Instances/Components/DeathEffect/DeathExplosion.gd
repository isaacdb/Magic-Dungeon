class_name DeathComponent
extends Node2D

@onready var explosionAnimPlayer := $ExplosionSprite/AnimationPlayerExplosion as AnimationPlayer
@onready var explosionParticle := $ExplosionSprite/ExplosionParticle as CPUParticles2D
@onready var smokeParticle := $ExplosionSprite/SmokeParticle as CPUParticles2D

func Execute() -> void:	
	Global.emit_signal("screen_shake", 2, .2, 1)
	explosionParticle.emitting = true
	
	if GeneralSettingsManager.dustParticles:
		smokeParticle.emitting = true;
		
	explosionAnimPlayer.play("Explosion")
	self.reparent(get_tree().get_first_node_in_group("Room"))
	get_tree().create_timer(2).timeout.connect(func(): queue_free())
	pass
