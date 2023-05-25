extends Panel
class_name UpgradeSelector

@export var optionUpgrade = preload("res://Instances/Components/UpgradeSelector/OptionItem.tscn")
@export var listOfUpgradesAvaiable : Array[UpgradeStats] = []

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

func UpgradeSelected(upgradeId: int):
	print("Upgrade selecionado id: ", upgradeId)
	
	# TODO - Passar o upgrade pro player
	
	self.visible = false
	get_tree().paused = false
	pass

func GetRandomUpgrade() -> UpgradeStats:
	var randIndex := rnd.randi_range(0, listOfUpgradesAvaiable.size() -1)
	
	while chosenUpgradesIndex.find(randIndex) != -1:
		randIndex = rnd.randi_range(0, listOfUpgradesAvaiable.size())
	
	chosenUpgradesIndex.append(randIndex)
	
	return listOfUpgradesAvaiable[randIndex]
