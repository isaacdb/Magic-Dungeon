extends ProgressBar

@export var xpRequiredPerLevel := 10

var xpNextLevel := 0
var currentXp := 0

func _ready():
	Global.xp_colleted.connect(AddXp)
	xpNextLevel = xpRequiredPerLevel
	SetMaxValue(xpNextLevel)
	UpdateProgressBar()
	pass

func AddXp():
	currentXp += 1
	CheckLevelUp()
	UpdateProgressBar()
	pass

func CheckLevelUp():
	if currentXp >= xpNextLevel:
		print("level up")
		currentXp = 0
		xpNextLevel += 5
		SetMaxValue(xpNextLevel)
	pass

func SetMaxValue(newMaxValue):
	max_value = newMaxValue
	pass
	
func UpdateProgressBar():
	var tween = create_tween()
	tween.tween_property(self, "value", currentXp, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()	
	pass
