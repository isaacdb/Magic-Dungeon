extends UpgradeStats
class_name BounceUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.bulletStats.bounceTimes += upgradeValue
	pass
