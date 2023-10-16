extends Node2D

func _init():
	StatsManager.SetupStartStats();
	Global.playerIsAlive = true;
	Global.gameFinished = false
	ProgressManager.CleanProgress();
	UpgradeManager.CleanUpgrades();

func _ready():
	pass
