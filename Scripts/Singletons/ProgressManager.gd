extends Node

@export var roomsAvailable := 4
@export var bossRoomsAvailable := 1

@onready var rand = RandomNumberGenerator.new()

var roomsUseds : Array[int]
var bossRoomsUseds : Array[int]
var enemiesPackUseds : Array[int]
var bossPackUseds : Array[int]

const bossRoomNumber := 5
var currentRoomNumber := 0
var bossKillCount := 0

func _ready():
	rand.randomize();
	Global.boss_killed
	pass

func GameEnd() -> void:
	
	pass

func CleanProgress():
	currentRoomNumber = 0;
	bossPackUseds.clear();
	enemiesPackUseds.clear();
	roomsUseds.clear();
	bossRoomsUseds.clear();
	bossKillCount = 0;
	pass
	
func LoadNewRoom() -> void:
	currentRoomNumber += 1;
	if IsBossRoom():
		get_tree().change_scene_to_file("res://Levels/BossRooms/BossRoom" + str(GetRandomBossRoom()) + ".tscn")
		return
		
	get_tree().change_scene_to_file("res://Levels/Rooms/Room" + str(GetRandomRoom()) + ".tscn")
	pass

func IsBossRoom() -> bool:
	return not currentRoomNumber % bossRoomNumber
	
func GetRandomRoom() -> int:
	var roomIndex = rand.randi_range(1, roomsAvailable);
	
	while roomsUseds.any(func(number): return number == roomIndex):
		roomIndex = rand.randi_range(1, roomsAvailable);
	
	roomsUseds.insert(0, roomIndex);
	
	return roomIndex;	
	
func GetRandomBossRoom() -> int:
	var bossRoomIndex = rand.randi_range(1, bossRoomsAvailable);
	
	while bossRoomsUseds.any(func(number): return number == bossRoomIndex):
		bossRoomIndex = rand.randi_range(1, bossRoomsAvailable);
	
	bossRoomsUseds.insert(0, bossRoomIndex);
	return bossRoomIndex;

func GetRandomEnemyPack() -> int:
	var enemiesPackAvailable = get_number_of_enemy_packs();
	var enemyPackIndex = rand.randi_range(1, enemiesPackAvailable);
	
	while enemiesPackUseds.any(func(number): return number == enemyPackIndex):
		enemyPackIndex = rand.randi_range(1, enemiesPackAvailable);
	
	enemiesPackUseds.insert(0, enemyPackIndex);
	
	return enemyPackIndex;
	
func get_number_of_enemy_packs() -> int:
	var count: int = 0
	var dir = DirAccess.open("res://Instances/Resources/EnemiesPack/Nivel1/")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir() and file_name.contains(".tres"):
				count +=1;
			file_name = dir.get_next()
	else:
		print("ERRO AO TENTAR BUSCAR QUANTIDADE DE PACKS DE INIMIGOS")
	
	return count;
