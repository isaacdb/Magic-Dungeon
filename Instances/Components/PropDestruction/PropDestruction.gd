extends Node2D

@onready var explosionParticle := $ExplosionParticle as CPUParticles2D
@onready var smokeParticle := $SmokeParticle as CPUParticles2D


func Execute():
	Global.emit_signal("screen_shake", 1, .2, 1)
	explosionParticle.emitting = true
	smokeParticle.emitting = true
	self.reparent(get_tree().get_root())
