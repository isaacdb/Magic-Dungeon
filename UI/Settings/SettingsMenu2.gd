extends Control
class_name SettingsMenu2

@onready var tab_bar = %TabBar as TabBar
@onready var general_settings = $GeneralSettings  as Control
@onready var audio_settings = $AudioSettings as Control
@onready var key_mapping = $KeyMapping  as Control

func _ready():
	tab_bar.tab_changed.connect(SetPanelByTab);
	
	SetPanelByTab(0);
	
	self.visible = false;
	pass
	
func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("esc"):
		OpenCloseSettingsMenu();
	pass
	
func OpenCloseSettingsMenu() -> void:
	if Global.panelUpgradeIsOpen or\
	 	not Global.playerIsAlive or\
		Global.gameFinished:
		return

	SetPanelByTab(0);
	self.visible = !self.visible;
	get_tree().paused = self.visible
	pass

func SetPanelByTab(tabIndex: int) -> void:
	tab_bar.current_tab = tabIndex
	general_settings.visible = tabIndex == 0
	key_mapping.visible = tabIndex == 1
	audio_settings.visible = tabIndex == 2
	pass
