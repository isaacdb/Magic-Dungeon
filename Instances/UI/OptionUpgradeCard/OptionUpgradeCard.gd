extends Button
class_name OptionUpgradeCard

@onready var title := %Title as Label
@onready var iconRect := %Icon as TextureRect
@onready var descriptionPro = %LabelPro as Label
@onready var descriptionContra = %LabelContra as Label

var upgradeSelector : UpgradeSelectorCard
var upgradeStats : UpgradeStats

func _ready():
	button_down.connect(Selected)
	pass
	
func Initialize(upgradeSelectorInject: UpgradeSelectorCard, upgradeStatsInject: UpgradeStats):
	upgradeSelector = upgradeSelectorInject
	upgradeStats = upgradeStatsInject
	title.text = upgradeStats.title
	iconRect.texture = upgradeStats.icon
	descriptionPro.text = "- " + upgradeStats.descriptionPro
	
	if upgradeStats.descriptionContra:
		descriptionContra.text = "- " + upgradeStats.descriptionContra
	pass
	
func DisableButton() -> void:
	button_down.disconnect(Selected);
	pass
	
func Selected():
	upgradeSelector.UpgradeSelected(upgradeStats)
	pass
