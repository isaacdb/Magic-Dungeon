extends UpgradeStats
class_name DashStackUpgrade

func Apply(player: Mage1):
	if VerifyApliedStacks():
		player.dashSkill.AddDashStack()
		Global.dash_stack_adquired.emit()
	pass
