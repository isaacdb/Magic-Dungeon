extends UpgradeStats
class_name MoveSpeedUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		var newSpeed = player.speed + MathUtil.CalculateValueByPercent(upgradeValue, player.speed)
		player.speed = newSpeed
		
		var newAcceleration = player.acceleration + MathUtil.CalculateValueByPercent(upgradeValue / 2, player.acceleration)		
		player.acceleration = newAcceleration
	pass
