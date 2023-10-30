extends Node2D

@onready var impact_paticle = $ImpactPaticle as CPUParticles2D

func Execute():
	Global.player_dead.emit()
	impact_paticle.reparent(get_tree().get_first_node_in_group("Room"));
	impact_paticle.emitting = true
	
	pass
