extends Resource
class_name UpgradeStats

enum UpgradeTypes{
	FireRate,
	Life,
	MoveSpeed,
	BulletDamage
}

@export var id : int
@export var title : String
@export var descriptionPro : String:
	get: return descriptionPro.replace("#", str(upgradeValue));
	
@export var descriptionContra : String:
	get: return descriptionContra.replace("$", str(abs(downgradeValue)));
	
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

