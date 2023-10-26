extends Button

@export var settingMenu : SettingsMenu2

func _ready():
	pressed.connect(OpenSettingsMenu)
	mouse_entered.connect(func(): Global.mouseOverGUI = true)
	mouse_exited.connect(func(): Global.mouseOverGUI = false)
	pass
	
func OpenSettingsMenu() -> void:
	settingMenu.OpenCloseSettingsMenu()
	pass


