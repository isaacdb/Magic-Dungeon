extends PanelContainer
class_name OptionItem

@onready var button := %ButtonOption as Button
@onready var text := %OptionText as Label
@onready var iconRect := %Icon as TextureRect
@onready var description_text = %DescriptionText as Label

var upgradeSelector : UpgradeSelector
var upgradeStats : UpgradeStats

func _ready():
	
	var style_box = StyleBoxFlat.new()
	
	style_box.set_bg_color(Color("#e9d3a9"))
	style_box.set_border_width_all(5)
	style_box.border_color = Color("#181425")
	style_box.set_corner_radius_all(10)
	#style_box.set_expand_margin_all(20)
	style_box.set_content_margin_all(10)
	# We assume here that the `theme` property has been assigned a custom Theme beforehand.
	theme.set_stylebox("panel", "TooltipPanel", style_box)
	
	button.button_down.connect(Selected)
	pass
	
func Initialize(upgradeSelectorInject: UpgradeSelector, upgradeStatsInject: UpgradeStats):
	upgradeSelector = upgradeSelectorInject
	upgradeStats = upgradeStatsInject
	text.text = upgradeStats.title
	iconRect.texture = upgradeStats.icon
	tooltip_text = upgradeStats.description
	description_text.text = upgradeStats.description	
	pass
	
func DisableButton() -> void:
	button.button_down.disconnect(Selected);
	pass
	
func Selected():
	upgradeSelector.UpgradeSelected(upgradeStats)
	pass
