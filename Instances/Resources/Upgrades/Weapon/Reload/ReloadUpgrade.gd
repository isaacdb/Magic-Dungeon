extends UpgradeStats
class_name ReloadUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		var currenteReload = player.weapon.reloadTime;
		var reloadPercent = (currenteReload * upgradeValue) / 100.0;
		var newReloadTime = currenteReload - reloadPercent;
		player.weapon.SetupReloadTime(newReloadTime);
	pass
