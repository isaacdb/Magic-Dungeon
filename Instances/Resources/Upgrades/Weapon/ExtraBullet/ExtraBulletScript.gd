extends UpgradeStats
class_name ExtraBulletUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.bulletStats.bulletFireAmount += upgradeValue;
		player.weapon.bulletStats.ApplyUpgradeDamage(downgradeValue);
	pass
