extends ProgressBar
class_name LevelUpManager

@export var xpRequiredPerLevel := 100
@export var xpDificultMultiply := 10
@export var xpUnitValue := 20

var currentLevel := 0
var xpNextLevel := 0
var currentXp := 0

func _ready() -> void:
	Global.xp_colleted.connect(AddXp)
	xpNextLevel = xpRequiredPerLevel
	SetupCurrentLevelAndXp()
	pass

func SetupCurrentLevelAndXp() -> void:
	xpNextLevel = xpRequiredPerLevel
	for i in range(0, StatsManager.currentLevel - 1):
		xpNextLevel = ValueXpRequiredNextLevel();
		
	currentXp = StatsManager.currentXp * xpUnitValue
	value = currentXp
	pass

func ValueXpRequiredNextLevel() -> int:
	return xpNextLevel * (xpDificultMultiply + 100);

func AddXp() -> void:
	currentXp += xpUnitValue
	if CheckLevelUp():
		LevelUpEffect()
	else:
		UpdateProgressBar()
	pass

func CheckLevelUp() -> bool:
	if currentXp >= xpNextLevel:
		currentXp = 0
		xpNextLevel = ValueXpRequiredNextLevel();
		Global.level_up.emit()
		return true
	
	return false

func UpdateMaxValue(newMaxValue: int) -> void:
	max_value = newMaxValue
	pass

func LevelUpEffect() -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", max_value, 0.3).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "value", max_value, 2.0).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "max_value", ValueXpRequiredNextLevel(), 0)
	tween.tween_property(self, "value", currentXp, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()
	
func UpdateProgressBar() -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", currentXp, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()
	pass
