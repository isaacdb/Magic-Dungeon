extends UpgradeStats
class_name BoostFireRateWhenHitedUpgrade

var stacks := 0
var playerAux : Mage1

@export var durationTime := 3.0

func Apply(player: Mage1):
	if VerifyApliedStacks():
		stacks += 1
		playerAux = player
		if stacks == 1:
			Global.player_hited.connect(GetBoost)
	pass

func Clean():
	Global.player_hited.disconnect(GetBoost)
	pass

func GetBoost() -> void:
	if not playerAux:
		print("PLAYER NAO ENCONTRADO PARA APLICAR UPGRADE BOOST FIRE RATE WHEN HITED")
		return
	
	ApplyBoostFireRate();
	playerAux.get_tree().create_timer(stacks * durationTime).timeout.connect(EndBoost);
	pass

func EndBoost() -> void:
	print("End")
	if playerAux and playerAux != null:
		playerAux.weapon.SetupFireRate(playerAux.weapon.fireRate);
	pass
	
func ApplyBoostFireRate() -> void:
	var currentFireRate = playerAux.weapon.fireRate;
	var fireRatePercent = (currentFireRate * upgradeValue) / 100.0;
	var fireRateBoosted = currentFireRate - fireRatePercent;
	playerAux.weapon.SetupFireRateBoost(fireRateBoosted);
	pass
