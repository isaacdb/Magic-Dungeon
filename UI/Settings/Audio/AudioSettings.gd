extends Control
class_name AudioSettings

@export var settingMenu : SettingsMenu2

@onready var button_back = %ButtonBack as Button

func _ready():
	button_back.pressed.connect(_on_button_back_pressed);
	pass
	
func _on_button_back_pressed():
	settingMenu.OpenCloseSettingsMenu()
	pass
