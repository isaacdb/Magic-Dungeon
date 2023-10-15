extends UpgradeStats
class_name AmmunitionAmountUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.ammunitionAmount += upgradeValue
		player.weapon.RealodComplete();
	pass
