extends ProgressBar
class_name LevelUpManager

@export var xpRequiredBase := 100
@export var xpDificultMultiply := 10
@export var xpUnitValue := 20

var currentLevel := 0
var currentXp := 0

func _ready() -> void:
	Global.xp_colleted.connect(AddXp)
	SetupCurrentLevelAndXp()
	pass

func SetupCurrentLevelAndXp() -> void:
	max_value = xpRequiredBase
	for i in range(0, StatsManager.currentLevel):
		max_value = ValueXpRequiredNextLevel();
		
	currentXp = StatsManager.currentXp * xpUnitValue;
	value = currentXp;
	pass

func ValueXpRequiredNextLevel() -> int:
	print(max_value * (xpDificultMultiply + 100) / 100)
	return max_value * (xpDificultMultiply + 100) / 100;

func AddXp() -> void:
	currentXp += xpUnitValue
	if CheckLevelUp():
		LevelUpEffect()
	else:
		UpdateProgressBar()
	pass

func CheckLevelUp() -> bool:
	if currentXp >= max_value:
		currentXp = 0
		max_value = ValueXpRequiredNextLevel();
		Global.level_up.emit()
		return true
	
	return false

func UpdateMaxValue(newMaxValue: int) -> void:
	max_value = newMaxValue
	pass

func LevelUpEffect() -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", max_value, 0.3).set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self, "value", currentXp, 0.5).set_trans(Tween.TRANS_LINEAR)
	tween.play()

func UpdateProgressBar() -> void:
	var tween = create_tween()
	tween.tween_property(self, "value", currentXp, 0.8).set_trans(Tween.TRANS_LINEAR)
	tween.play()
	pass
