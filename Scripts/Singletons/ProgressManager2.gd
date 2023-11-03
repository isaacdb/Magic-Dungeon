extends Node

@export var roomsAvailable := 4
@export var bossRoomsAvailable := 1
@export var difficultMultiply := 50.0

@onready var rand = RandomNumberGenerator.new()

var roomsUseds : Array[int]
var bossRoomsUseds : Array[int]
var enemiesResources : Array[Resource] = []
var startDifficult := 1.0
var currentRoomNumber := 0

const bossRoomNumber := 10

func _ready():
	enemiesResources = FileLoader.get_resouces_by_folder("res://Instances/Resources/EnemiesPack/EnemyImpact/")
	rand.randomize();
	Global.boss_killed
	pass

func CleanProgress():
	currentRoomNumber = 0;
	roomsUseds.clear();
	bossRoomsUseds.clear();
	pass
	
func GetDifficultAmount() -> float:
	return startDifficult + ((startDifficult + currentRoomNumber) * ((difficultMultiply / 100) * currentRoomNumber))
	
func LoadNewRoom() -> void:
	currentRoomNumber += 1;
	if IsBossRoom():
		get_tree().change_scene_to_file("res://Levels/BossRooms/BossRoom" + str(get_random_boss_room_index()) + ".tscn")
		return
		
	get_tree().change_scene_to_file("res://Levels/Rooms/Room" + str(get_random_room_index()) + ".tscn")
	pass

func IsBossRoom() -> bool:
	return not currentRoomNumber % bossRoomNumber
	
func get_random_enemy_impact() -> EnemyImpact:
	return enemiesResources[rand.randi_range(0, enemiesResources.size() - 1)]
	
func get_random_room_index() -> int:
	var roomIndex = rand.randi_range(1, roomsAvailable);
	
	while roomsUseds.any(func(number): return number == roomIndex):
		roomIndex = rand.randi_range(1, roomsAvailable);
	
	roomsUseds.insert(0, roomIndex);
	if roomsUseds.size() == roomsAvailable:
		roomsUseds.clear();
		
	return roomIndex;
	
func get_random_boss_room_index() -> int:
	var bossRoomIndex = rand.randi_range(1, bossRoomsAvailable);
	
	while bossRoomsUseds.any(func(number): return number == bossRoomIndex):
		bossRoomIndex = rand.randi_range(1, bossRoomsAvailable);
	
	bossRoomsUseds.insert(0, bossRoomIndex);
	return bossRoomIndex;
