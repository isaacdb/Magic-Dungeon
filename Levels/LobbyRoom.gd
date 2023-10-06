extends Node2D

func _init():
	StatsManager.SetupStartStats();
	Global.playerIsAlive = true;
	ProgressManager.CleanProgress();

func _ready():
	pass
