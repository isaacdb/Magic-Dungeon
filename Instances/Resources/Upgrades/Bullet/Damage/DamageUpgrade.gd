extends UpgradeStats
class_name DamageUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.bulletStats.damage += upgradeValue
	pass
