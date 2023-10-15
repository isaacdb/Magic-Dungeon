extends UpgradeStats
class_name DamageUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		var currentDamage = player.weapon.bulletStats.damage
		var newDamage = currentDamage + MathUtil.CalculateValueByPercent(upgradeValue, currentDamage)
		player.weapon.bulletStats.damage = newDamage
	pass
