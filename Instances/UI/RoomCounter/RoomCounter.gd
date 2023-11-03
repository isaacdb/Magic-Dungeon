extends PanelContainer
class_name RoomCounter

@export var roomIcon : Texture2D
@export var roomIconDefeated : Texture2D
@export var currentRoomIcon : Texture2D
@export var bossRoomIcon : Texture2D
@export var currentBossRoom : Texture2D

@onready var containerRooms := %ContainerRooms as HBoxContainer
@onready var containerBossRoom := %ContainerBossRoom as HBoxContainer

func _ready():
	if ProgressManager2.currentRoomNumber == 0:
		visible = false;
	else:
		visible = true;
		CreateIcons();
		ShowUp();
	pass
	
func ShowUp() -> void:
	var tween = self.create_tween()
	tween.tween_property(self, "position:y", 50, 2).from(-200).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_interval(1.5)
	tween.tween_property(self, "position:y", -200, 1).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	pass

func CreateIcons() -> void:
	for i in range(1, ProgressManager2.bossRoomNumber):
		var newIcon = TextureRect.new()
		newIcon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
		newIcon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		
		if ProgressManager2.currentRoomNumber > i:
			#Defeated rooms
			newIcon.texture = roomIconDefeated;
		elif ProgressManager2.currentRoomNumber == i:
			#Battle Icon
			newIcon.texture = currentRoomIcon;
		else:
			#Next battles
			newIcon.texture = roomIcon
			
		containerRooms.add_child(newIcon)
	
	var bossIcon = TextureRect.new()
	bossIcon.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	bossIcon.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	bossIcon.texture = bossRoomIcon
	if ProgressManager2.IsBossRoom():
		bossIcon.texture = currentBossRoom
		# Boss Battle
		
	containerBossRoom.add_child(bossIcon)
	pass

