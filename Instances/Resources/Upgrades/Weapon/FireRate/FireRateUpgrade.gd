extends UpgradeStats
class_name FireRateUpgrade

func Apply(player: Mage1):
	var currenteFireRate = player.weapon.fireRate;
	var fireRatePercent = (currenteFireRate * upgradeValue) / 100.0;
	var newFireRate = currenteFireRate - fireRatePercent;
	player.weapon.SetupFireRate(newFireRate);
	pass
