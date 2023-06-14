extends ProgressBar

@export var xpRequiredPerLevel := 100

var xpNextLevel := 0
var currentXp := 0

func _ready():
	Global.xp_colleted.connect(AddXp)
	xpNextLevel = xpRequiredPerLevel
	UpdateMaxValue()
	UpdateProgressBar()
	pass

func AddXp():
	currentXp += 20
	if CheckLevelUp():
		LevelUpEffect()
	else:
		UpdateProgressBar()
	pass

func CheckLevelUp() -> bool:
	if currentXp >= xpNextLevel:
		currentXp = 0
		xpNextLevel += 10
		Global.level_up.emit()
		return true
	
	return false

func UpdateMaxValue():
	max_value = xpNextLevel
	pass

func LevelUpEffect():
	var tween = create_tween()
	tween.tween_property(self, "value", max_value, 0.3).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "value", max_value, 2.0).set_trans(Tween.TRANS_LINEAR)
	tween.tween_callback(UpdateMaxValue)
	tween.tween_property(self, "value", currentXp, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()		
	
func UpdateProgressBar():
	var tween = create_tween()
	tween.tween_property(self, "value", currentXp, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()	
	pass
