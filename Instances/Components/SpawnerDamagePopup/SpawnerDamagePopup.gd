extends Marker2D

var popupPrefab = preload("res://Instances/Components/PopupText/PopupText.tscn");

func _ready():
	var parentHealth = get_parent() as Health
	if parentHealth:
		parentHealth.damage.connect(SpawnDamagePopup)
	pass
	
func SpawnDamagePopup(attack: Attack) -> void:
	print("spawn")
	var newDamagePopup = popupPrefab.instantiate() as PopupText
	var parent = get_tree().get_first_node_in_group("DamagePopupParent")
	parent.add_child(newDamagePopup)
	newDamagePopup.global_position = global_position
	newDamagePopup.SetTextAndPlay(str(attack.damage), global_position)
	pass
