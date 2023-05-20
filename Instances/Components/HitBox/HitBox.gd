extends Area2D
class_name HitBoxComponent

signal attack_enter

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
		attack.knock_back = 100
		attack.direction = self.global_position
		
		area.take_damage(attack)
		attack_enter.emit()
	return
