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
@export var downgradeValue : float:
	get: return - downgradeValue;
		
@export var icon : Texture2D

var upgradeStack := 0
var apliedTimes := 0

func Apply(player: Mage1):
	pass
	
func Clean():
	upgradeStack = 0;
	apliedTimes = 0;
	pass
	
func VerifyApliedStacks() -> bool:
	if apliedTimes < upgradeStack:
		apliedTimes += 1;
		return true
		
	return false

