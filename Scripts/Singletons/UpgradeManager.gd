extends Node

var listOfUpgradesAvaiable : Array[Resource] = []
var listOfUpgradesAdquired : Array[UpgradeStats] = []

func _init():
	listOfUpgradesAvaiable = FileLoader.get_resouces_by_folder("res://Instances/Resources/Upgrades/");
	pass
		
func ApplyUpgradesAdquired():
	var player = GetPlayer();
	# Need to wait the end of the frame to load all the components of the player that the upgrades can use
	await player.get_tree().process_frame
	for upgrade in listOfUpgradesAdquired:
		upgrade.apliedTimes = 0;
		for stack in range(0, upgrade.upgradeStack):
			upgrade.Apply(player);
	pass

func AddNewUpgrade(newUpgrade: UpgradeStats):
	newUpgrade.upgradeStack += 1
	newUpgrade.Apply(GetPlayer());
	
	var indexUpgradeAlreadyAdquired = listOfUpgradesAdquired.find(newUpgrade);
	if indexUpgradeAlreadyAdquired == -1:
		listOfUpgradesAdquired.insert(0, newUpgrade);
		
	pass

func GetPlayer() -> Mage1:
	return get_tree().get_nodes_in_group("player")[0] as Mage1
		
func CleanUpgrades():
	for upgrade in listOfUpgradesAdquired:
		upgrade.Clean()
	
	listOfUpgradesAdquired = []
	pass
