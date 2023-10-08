extends UpgradeStats
class_name DamageUpgrade

var apliedToResource := false

func Apply(player: Mage1):
	if not apliedToResource:
		apliedToResource = true
		player.weapon.bulletStats.damage += upgradeValue
	pass
