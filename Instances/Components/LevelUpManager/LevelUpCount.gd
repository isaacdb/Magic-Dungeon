extends Label

var levelCount := 1;

func _ready() -> void:
	Global.level_up.connect(LevelUp);
	PrintNewLevel();
	pass
	
func LevelUp() -> void:
	levelCount += 1;
	PrintNewLevel();
	pass
	
func PrintNewLevel() -> void:
	var numberString = str(levelCount);
	if (numberString.length() == 1): 
		numberString = "0" + numberString;	
	
	self.text = numberString;
	pass
