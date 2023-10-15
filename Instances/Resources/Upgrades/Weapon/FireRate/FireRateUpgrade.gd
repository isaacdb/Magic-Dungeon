extends UpgradeStats
class_name FireRateUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		var newFireRate = player.weapon.fireRate - MathUtil.CalculateValueByPercent(upgradeValue, player.weapon.fireRate)
		player.weapon.SetupFireRate(newFireRate);
	pass
