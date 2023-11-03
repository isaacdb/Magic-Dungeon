extends UpgradeStats
class_name FireRateUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.ApplyUpgradeFireRate(upgradeValue);
		player.weapon.bulletStats.ApplyUpgradeDamage(downgradeValue);
	pass
