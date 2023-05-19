extends Area2D

@export var damage := 0.0

func _ready():	
	monitorable = false
	monitoring = true
	
	connect("area_entered", _on_area_entered)
	pass 

func _on_area_entered(area):		
	if area is Health:
		var attack = Attack.new()
		attack.damage = damage
		
		area.take_damage(attack)
		
	return
