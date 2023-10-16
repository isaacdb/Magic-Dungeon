extends PanelContainer
class_name OptionItem

@onready var button := %ButtonOption as Button
@onready var text := %OptionText as Label
@onready var iconRect := %Icon as TextureRect

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
	
func DisableButton() -> void:
	button.button_down.disconnect(Selected);
	pass
	
func Selected():
	upgradeSelector.UpgradeSelected(upgradeStats)
	pass
