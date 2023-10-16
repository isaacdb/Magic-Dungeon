extends Panel
class_name UpgradeSelector

@export var optionUpgrade = preload("res://Instances/UI/OptionUpgrade/OptionItem.tscn")

@onready var boxOptionList = %OptionList as VBoxContainer
@onready var rnd = RandomNumberGenerator.new()
@onready var audioConfirm := $AudioPlayerSelectUpgrade as AudioStreamPlayer2D
@onready var audioLevelUp := $AudioPlayerLevelUp as AudioStreamPlayer2D

var listOfUpgradesAvaiable : Array[UpgradeStats] = []
var chosenUpgradesIndex : Array[int] = []

func _ready():
	Global.level_up.connect(ActiveSelector)
	listOfUpgradesAvaiable = UpgradeManager.listOfUpgradesAvaiable
	pass
	
func ActiveSelector():
	self.visible = true
	get_tree().paused = true

	var tween = self.create_tween()
	tween.tween_property(self, "position:y", 87, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).from(-830)
	tween.play()
	
	Global.panelUpgradeIsOpen = true;
	
	if Settings.soundEffect:
		audioLevelUp.play()
	
	for i in 3:
		var upgradeStats = GetRandomUpgrade()
		
		var newOption = optionUpgrade.instantiate() as OptionItem
		boxOptionList.add_child(newOption)
		newOption.Initialize(self, upgradeStats)
	pass

func UpgradeSelected(upgrade: UpgradeStats):
	UpgradeManager.AddNewUpgrade(upgrade);
	DisabledButtons();
	
	if Settings.soundEffect:
		audioConfirm.play();
	
	# Usefull for dont catch click input of button to fire in game
	var tween = create_tween()
	tween.tween_property(self, "position:y", -830, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN).from(87)
	tween.tween_callback(func(): self.visible = false)
	tween.tween_callback(CleanUpgradesListed)
	tween.tween_callback(func(): get_tree().paused = false)
	tween.tween_callback(func(): Global.panelUpgradeIsOpen = false)
	tween.play()
	pass

func DisabledButtons() -> void:
	var upgrades = boxOptionList.get_children() as Array[OptionItem]
	for i in upgrades:
		i.DisableButton();
	pass

func CleanUpgradesListed():
	chosenUpgradesIndex.clear()
	var upgrades = boxOptionList.get_children()
	for i in upgrades:
		i.queue_free()
	pass

func GetRandomUpgrade() -> UpgradeStats:
	var randIndex := rnd.randi_range(0, listOfUpgradesAvaiable.size() -1)
	
	while chosenUpgradesIndex.find(randIndex) != -1:
		randIndex = rnd.randi_range(0, listOfUpgradesAvaiable.size() -1)
	
	chosenUpgradesIndex.append(randIndex)
	
	return listOfUpgradesAvaiable[randIndex]
