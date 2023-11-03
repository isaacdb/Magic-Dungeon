extends UpgradeStats
class_name DamageUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.bulletStats.ApplyUpgradeDamage(upgradeValue);
		player.weapon.ApplyUpgradeFireRate(downgradeValue);
	pass
