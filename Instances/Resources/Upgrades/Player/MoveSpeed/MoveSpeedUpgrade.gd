extends UpgradeStats
class_name MoveSpeedUpgrade

func Apply(player: Mage1):
	var upgradePercent = upgradeValue / player.speed
	player.speed += upgradeValue
	player.acceleration += player.acceleration * upgradePercent / 2
	pass
