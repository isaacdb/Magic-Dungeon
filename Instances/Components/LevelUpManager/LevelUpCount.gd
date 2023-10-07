extends Label

var levelCount := 1;

func _ready() -> void:
	Global.level_up.connect(LevelUp);
	SetupCurrentLevel();
	pass

func SetupCurrentLevel() -> void:
	levelCount = StatsManager.currentLevel;
	PrintNewLevel();
	pass

func LevelUp() -> void:
	levelCount += 1;
	PrintNewLevel();
	pass
	
func PrintNewLevel() -> void:
	self.text = StringUtil.IntToString(levelCount);
	pass
