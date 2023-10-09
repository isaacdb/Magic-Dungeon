extends UpgradeStats
class_name IFrameUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.durationIFrame += upgradeValue
		player.SetupIFrameTimer(player.durationIFrame)
	pass
