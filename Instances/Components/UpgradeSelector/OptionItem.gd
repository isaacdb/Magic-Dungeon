extends Panel
class_name OptionItem

@onready var button := $ButtonOption as Button
@onready var text := $OptionText as Label
@onready var iconRect := $iconPanel/icon as TextureRect

var upgradeSelector : UpgradeSelector
var upgradeStats : UpgradeStats

func _ready():
	button.button_down.connect(Selected)
	pass
	
func Initialize(upgradeSelectorInject: UpgradeSelector, upgradeStatsInject: UpgradeStats):
	upgradeSelector = upgradeSelectorInject
	upgradeStats = upgradeStatsInject
	text.text = upgradeStats.title
	iconRect.texture = upgradeStats.icon
	pass
	
func Selected():
	upgradeSelector.UpgradeSelected(upgradeStats)
	pass
