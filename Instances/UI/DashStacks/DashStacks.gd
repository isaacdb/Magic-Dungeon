extends VBoxContainer

var dashStacksAmount := 1
var dashProgressBar = preload("res://Instances/UI/DashStacks/DashProgress/DashProgressBar.tscn")

func _ready():
	Global.player_dash.connect(PlayerDash)
	Global.dash_stack_adquired.connect(AddDashStack)
	pass
	
func AddDashStack() -> void:
	dashStacksAmount += 1
	var newDashProgress = dashProgressBar.instantiate() as DashProgressBar
	self.add_child(newDashProgress)
	pass

func PlayerDash() -> void:
	for i in get_children() as Array[DashProgressBar]:
		if i.isFull:
			i.DashUsed();
			move_child(i, 0)
			return
	pass
