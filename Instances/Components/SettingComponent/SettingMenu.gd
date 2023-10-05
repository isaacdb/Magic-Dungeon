extends Panel
class_name SettingMenu

@export var buttonCameraShake : CheckButton
@export var buttonDustExplosion : CheckButton
@export var buttonSoundEffect : CheckButton
@export var buttonMusic : CheckButton

func _ready():
	buttonCameraShake.button_pressed = Settings.cameraShake;
	buttonCameraShake.pressed.connect(PressCameraShake);
	
	buttonDustExplosion.button_pressed = Settings.dustExplosion;
	buttonDustExplosion.pressed.connect(PressDustExplosion);
		
	buttonSoundEffect.button_pressed = Settings.soundEffect;
	buttonSoundEffect.pressed.connect(PressSoundEffect);
	
	buttonMusic.button_pressed = Settings.music;
	buttonMusic.pressed.connect(PressMusic);
	
	self.visible = false;
	pass
	
func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("esc"):
		OpenCloseSettingsMenu();
	pass
	
func OpenCloseSettingsMenu() -> void:
	if Global.panelUpgradeIsOpen or not Global.playerIsAlive:
		return
	
	self.visible = !self.visible;
	get_tree().paused = self.visible
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
