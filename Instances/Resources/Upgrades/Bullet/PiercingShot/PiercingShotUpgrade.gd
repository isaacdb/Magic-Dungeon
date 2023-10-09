extends UpgradeStats
class_name PiercingShotUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.bulletStats.piercingShots += upgradeValue
	pass
