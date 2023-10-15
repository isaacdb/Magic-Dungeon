extends UpgradeStats
class_name ReloadUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		var newReloadTime = player.weapon.reloadTime - MathUtil.CalculateValueByPercent(upgradeValue, player.weapon.reloadTime)
		player.weapon.SetupReloadTime(newReloadTime);
	pass
