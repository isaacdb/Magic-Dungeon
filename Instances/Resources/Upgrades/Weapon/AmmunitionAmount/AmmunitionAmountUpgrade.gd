extends UpgradeStats
class_name AmmunitionAmountUpgrade

func Apply(player: Mage1):
	player.weapon.ammunitionAmount += upgradeValue
	pass
