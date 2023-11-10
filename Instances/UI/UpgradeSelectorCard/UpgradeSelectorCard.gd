extends Control
class_name UpgradeSelectorCard

@export var optionUpgradeCard = preload("res://Instances/UI/OptionUpgradeCard/option_upgrade_card.tscn")

@onready var rnd = RandomNumberGenerator.new()
@onready var audioConfirm := $AudioPlayerSelectUpgrade as AudioStreamPlayer2D
@onready var audioLevelUp := $AudioPlayerLevelUp as AudioStreamPlayer2D

var listOfUpgradesAvaiable : Array[Resource] = []
var chosenUpgradesIndex : Array[int] = []

func _ready():
	Global.level_up.connect(ActiveSelector)
	listOfUpgradesAvaiable = UpgradeManager.listOfUpgradesAvaiable;
	pass
	
func ActiveSelector():
	self.visible = true
	get_tree().paused = true

	var tween = self.create_tween()
	tween.tween_property(self, "position:y", 87, 0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT).from(-830)
	tween.play()
	
	Global.panelUpgradeIsOpen = true;
	
	audioLevelUp.play()
	
	var screen_size = get_viewport().get_visible_rect().size;
	var width = (screen_size.x - 300) / 3;
	for i in 3:
		var upgradeStats = GetRandomUpgrade()
		var newOption = optionUpgradeCard.instantiate() as OptionUpgradeCard
		add_child(newOption)
		newOption.Initialize(self, upgradeStats)
		newOption.position.x = (width * (i)) + ((width - newOption.size.x) / 2) + 150
	pass

func UpgradeSelected(upgrade: UpgradeStats):
	UpgradeManager.AddNewUpgrade(upgrade);
	DisabledButtons();
	
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
	var upgrades = get_children();
	for i in upgrades:
		if i.is_in_group("Card"):
			i.DisableButton();
	pass

func CleanUpgradesListed():
	chosenUpgradesIndex.clear()
	var upgrades = get_children();
	for i in upgrades:
		if i.is_in_group("Card"):
			i.queue_free();
	pass

func GetRandomUpgrade() -> UpgradeStats:
	var randIndex := rnd.randi_range(0, listOfUpgradesAvaiable.size() -1)
	
	while chosenUpgradesIndex.find(randIndex) != -1:
		randIndex = rnd.randi_range(0, listOfUpgradesAvaiable.size() -1)
	
	chosenUpgradesIndex.append(randIndex)
	
	return listOfUpgradesAvaiable[randIndex] as UpgradeStats;
