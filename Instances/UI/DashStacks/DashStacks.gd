extends VBoxContainer

var dashStacksAmount := 1
var dashProgressBar = preload("res://Instances/UI/DashStacks/DashProgressRounded/dashProgressRounded.tscn")

func _ready():
	Global.player_dash.connect(PlayerDash)
	Global.dash_stack_adquired.connect(AddDashStack)
	pass
	
func AddDashStack() -> void:
	dashStacksAmount += 1
	var newDashProgress = dashProgressBar.instantiate() as DashProgressRounded
	self.add_child(newDashProgress)
	pass

func PlayerDash() -> void:
	for i in get_children() as Array[DashProgressRounded]:
		if i.isFull:
			i.DashUsed();
			move_child(i, 0)
			return
	pass
