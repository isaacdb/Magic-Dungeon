extends Node2D

func _init():
	StatsManager.SetupStartStats();
	Global.playerIsAlive = true;
	Global.gameFinished = false
	ProgressManager2.CleanProgress();
	UpgradeManager.CleanUpgrades();
