extends Panel
class_name UpgradeSelector

@export var optionUpgrade = preload("res://Instances/Components/UpgradeSelector/OptionItem.tscn")
@export var listOfUpgradesAvaiable : Array[UpgradeStats] = []

@onready var boxOptionList = $OptionList as VBoxContainer
@onready var rnd = RandomNumberGenerator.new()
@onready var audioConfirm := $AudioPlayerSelectUpgrade as AudioStreamPlayer2D
@onready var audioLevelUp := $AudioPlayerLevelUp as AudioStreamPlayer2D

var chosenUpgradesIndex : Array[int] = []
var player : Mage1

func _ready():
	Global.level_up.connect(ActiveSelector)
	player = get_tree().get_nodes_in_group("player")[0] as Mage1
	pass
	
func ActiveSelector():
	self.visible = true
	get_tree().paused = true
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
	upgrade.ApplyUpgrade(player);
	
	if Settings.soundEffect:
		audioConfirm.play();
	
	CleanUpgradesListed()
	
	self.visible = false
	
	# Usefull for dont catch click input of button to fire in game
	var tween = create_tween()
	tween.tween_callback(func(): get_tree().paused = false).set_delay(0.5)
	tween.tween_callback(func(): Global.panelUpgradeIsOpen = false)
	tween.play()
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
