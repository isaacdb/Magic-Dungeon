extends Panel
class_name UpgradeSelector

@export var optionUpgrade = preload("res://Instances/Components/UpgradeSelector/OptionItem.tscn")
@export var listOfUpgradesAvaiable : Array[UpgradeStats] = []
@export var player : Mage1

@onready var boxOptionList = $OptionList as VBoxContainer
@onready var rnd = RandomNumberGenerator.new()

var chosenUpgradesIndex : Array[int] = []

func _ready():
	Global.level_up.connect(ActiveSelector)
	pass
	
func ActiveSelector():
	self.visible = true
	get_tree().paused = true
	
	for i in 3:
		var upgradeStats = GetRandomUpgrade()
		
		var newOption = optionUpgrade.instantiate() as OptionItem
		boxOptionList.add_child(newOption)
		newOption.Initialize(self, upgradeStats)
	pass

func UpgradeSelected(upgrade: UpgradeStats):
	upgrade.ApplyUpgrade(player)
	
	CleanUpgradesListed()
	
	self.visible = false
	get_tree().paused = false
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