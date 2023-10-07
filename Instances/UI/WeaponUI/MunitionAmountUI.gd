extends Label

func _ready():
	Global.player_fire.connect(UpdateAmmunitonAmount)
	pass
	
func UpdateAmmunitonAmount(amount: int) -> void:
	text = StringUtil.IntToString(amount);
	pass
