extends Node

var listOfUpgradesAvaiable : Array[UpgradeStats] = []

var listOfUpgradesAdquired : Array[UpgradeStats] = []

func _init():
	BuscarUpgradesPorPasta("res://Instances/Resources/Upgrades/");
	pass
		
func ApplyUpgradesAdquired():
	var player = GetPlayer();
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
	
func BuscarUpgradesPorPasta(path: String):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				BuscarUpgradesPorPasta(path + file_name + "/")
			else:
				if file_name.contains(".tres"):
					listOfUpgradesAvaiable.insert(0, ResourceLoader.load(path + file_name))
			file_name = dir.get_next()
	else:
		print("ERRO AO TENTAR CARREGAR UPGRADES NO UPGRADE MANAGER")
		
func CleanUpgrades():
	for upgrade in listOfUpgradesAdquired:
		upgrade.Clean()
	
	listOfUpgradesAdquired = []
	pass
