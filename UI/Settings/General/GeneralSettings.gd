extends Control
class_name GeneralSettings

@export var settingMenu : SettingsMenu2
@onready var button_back = %ButtonBack as Button

func _ready():
	button_back.pressed.connect(OpenSettingsMenu)
	pass
	
func OpenSettingsMenu() -> void:
	settingMenu.OpenCloseSettingsMenu()
	pass
