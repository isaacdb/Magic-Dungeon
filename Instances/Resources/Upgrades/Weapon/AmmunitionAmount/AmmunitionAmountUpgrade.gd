extends UpgradeStats
class_name AmmunitionAmountUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.weapon.ApplyUpgradeAmmunitonAmount(upgradeValue);
		player.weapon.ApplyUpgradeReloadTime(downgradeValue);
	pass
