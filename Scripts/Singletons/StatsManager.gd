extends Node

var currentLife: int;
var currentLevel: int;
var currentXp: int;
var currentAmmunition: int;

func _ready():
	Global.player_remove_life.connect(func(): currentLife -= 1);
	Global.player_add_life.connect(func(): currentLife += 1);
	Global.xp_colleted.connect(func(): currentXp += 1);
	Global.level_up.connect(func(): currentLevel += 1);
	Global.level_up.connect(func(): currentXp = 0);
	Global.player_fire.connect(AmmunitionChange)

func AmmunitionChange(amount: int) -> void:
	currentAmmunition = amount
	pass

func SetupStartStats():
	currentLevel = 1;
	currentLife = 3;
	currentXp = 0;
