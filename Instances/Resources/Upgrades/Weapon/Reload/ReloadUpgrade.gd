extends UpgradeStats
class_name ReloadUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.ApplyUpgradeReloadTime(upgradeType);
		player.weapon.ApplyUpgradeFireRate(downgradeValue);
	pass
