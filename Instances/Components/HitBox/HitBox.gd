extends Area2D
class_name HitBoxComponent

signal attack_enter

var damage := 0.0
var knockBackForce := 0.0

var isActive := false

func SetActive(active: bool):
	isActive = active
	pass

func _ready():	
	monitorable = true
	monitoring = true
	
	connect("area_entered", _on_area_entered)
	pass 

func _on_area_entered(area):
	if !isActive:
		return
	
	if area is Health:
		var attack = Attack.new()
		attack.damage = damage
		attack.knock_back = knockBackForce
		attack.direction = self.global_position
		
		area.take_damage(attack)
	
	attack_enter.emit()
	return
