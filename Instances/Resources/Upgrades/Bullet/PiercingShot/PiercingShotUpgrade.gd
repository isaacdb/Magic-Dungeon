extends UpgradeStats
class_name PiercingShotUpgrade

var apliedToResource := false

func Apply(player: Mage1):
	if not apliedToResource:
		apliedToResource = true
		player.weapon.bulletStats.piercingShots += upgradeValue
	pass
