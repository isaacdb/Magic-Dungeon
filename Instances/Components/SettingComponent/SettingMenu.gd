extends Panel
class_name SettingMenu

@export var buttonCameraShake : CheckButton
@export var buttonDustExplosion : CheckButton
@export var buttonSoundEffect : CheckButton
@export var buttonMusic : CheckButton

@onready var h_box_settings = %HBoxSettings as HBoxContainer
@onready var h_box_controls = %HBoxControls as HBoxContainer
@onready var tab_bar = %TabBar as TabBar

func _ready():
	buttonCameraShake.button_pressed = Settings.cameraShake;
	buttonCameraShake.pressed.connect(PressCameraShake);
	
	buttonDustExplosion.button_pressed = Settings.dustExplosion;
	buttonDustExplosion.pressed.connect(PressDustExplosion);
		
	buttonSoundEffect.button_pressed = Settings.soundEffect;
	buttonSoundEffect.pressed.connect(PressSoundEffect);
	
	buttonMusic.button_pressed = Settings.music;
	buttonMusic.pressed.connect(PressMusic);
	
	tab_bar.tab_changed.connect(SetPanelByTab);
	
	SetPanelByTab(1);
	
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
	h_box_settings.visible = tabIndex == 0
	h_box_controls.visible = tabIndex == 1
	pass
	
func PressCameraShake() -> void:
	Settings.cameraShake = buttonCameraShake.button_pressed;
	pass
	
func PressDustExplosion() -> void:
	Settings.dustExplosion = buttonDustExplosion.button_pressed;
	pass
	
func PressSoundEffect() -> void:
	Settings.soundEffect = buttonSoundEffect.button_pressed;
	pass
	
func PressMusic() -> void:
	Settings.music = buttonMusic.button_pressed;
	SoundTrack.PlayStop(buttonMusic.button_pressed);
	pass	
