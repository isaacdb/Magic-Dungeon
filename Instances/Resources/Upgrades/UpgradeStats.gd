extends Resource
class_name UpgradeStats

enum UpgradeTypes{
	FireRate,
	Life,
	MoveSpeed,
	BulletDamage
}

@export var id : int
@export var description : String
@export var title : String
@export var upgradeType : UpgradeTypes
@export var upgradeValue : float
@export var icon : Texture2D

func ApplyUpgrade(player: Mage1):
	match upgradeType:
		UpgradeTypes.FireRate:
			UpgradeFireRate(player)
			
		UpgradeTypes.Life:
			UpgradeLife(player)
			
		UpgradeTypes.BulletDamage:
			UpgradeBulletDamage(player)
			
		UpgradeTypes.MoveSpeed:
			UpgradeMoveSpeed(player)
	
	pass

func UpgradeFireRate(player: Mage1):
	player.fireRate -= upgradeValue
	player.UpdateFireRate(player.fireRate)
	pass
	
func UpgradeLife(player: Mage1):
	player.healthManager.AddHealth(1.0)
	Global.player_add_life.emit()
	pass
	
func UpgradeBulletDamage(player: Mage1):
	player.bulletStats.damage += upgradeValue
	pass
	
func UpgradeMoveSpeed(player: Mage1):
	var upgradePercent = upgradeValue / player.speed
	player.speed += upgradeValue
	player.acceleration += player.acceleration * upgradePercent / 2
	pass
