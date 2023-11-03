extends Node2D

@export var gateExit : Gate
@export var audioPlayer : AudioStreamPlayer2D

@onready var spawnPoints = self.get_node("SpawnPoints").get_children() as Array[Node2D]
@onready var rand = RandomNumberGenerator.new()

var spawnAlert = preload("res://Instances/Components/SpawnEffect/SpawnEffect.tscn")
var enemyPack : EnemyPack

var areaClean = false
var spawnPointsUsed : Array[int]
var enemiesCount := 0
var enemiesIdKilled : Array[int]
var waveCount := 0

func _ready():
	self.add_to_group("Room")
	rand.randomize();
	GetRandomEnemyPack();
	Global.enemy_killed.connect(enemy_killed);
	area_room_area_entered();
	pass
	
func GetRandomEnemyPack() -> void:
	if ProgressManager.IsBossRoom():
		var randBossPack = ProgressManager.GetRandomBossPack();
		enemyPack = ResourceLoader.load("res://Instances/Resources/EnemiesPack/Bosses/Boss" + str(randBossPack) + ".tres");		
	else:
		var randEnemyPack = ProgressManager.GetRandomEnemyPack("res://Instances/Resources/EnemiesPack/Nivel1/");
		enemyPack = ResourceLoader.load("res://Instances/Resources/EnemiesPack/Nivel1/Pack" + str(randEnemyPack) + ".tres");
	pass

func area_room_area_entered():
	audioPlayer.play();
		
	spawn_enemies()
	pass
	
func spawn_enemies() -> void:
	waveCount += 1
	var enemyNum := 0
	for enemy in enemyPack.enemies:
		for qntd in range(0, enemyPack.qntdEnemies[enemyNum]):
			var newSpawn = spawnAlert.instantiate() as SpawnAlert
			self.call_deferred("add_child", newSpawn)
			newSpawn.objectToSpawn = enemy
			newSpawn.global_position = get_random_spawn_point()
			enemiesCount += 1
			
		enemyNum += 1
	pass

func get_random_spawn_point() -> Vector2:
	var positionIndex = rand.randi_range(0, spawnPoints.size() - 1)
	
	while spawnPointsUsed.any(func(number): return number == positionIndex):
		positionIndex = rand.randi_range(0, spawnPoints.size() -  1)
	
	spawnPointsUsed.insert(0, positionIndex)
	
	return spawnPoints[positionIndex].global_position
	
func enemy_killed(enemy: CharacterBody2D) -> void:
	if enemiesIdKilled.find(enemy.get_instance_id()) != -1:
		return
		
	enemiesIdKilled.append(enemy.get_instance_id())
	
	if enemiesIdKilled.size() >= enemiesCount:
		if waveCount >= enemyPack.waveAmount:
			gateExit.open()
			areaClean = true
			Global.room_cleared.emit()
			audioPlayer.play()
		else:
			enemiesCount = 0;
			enemiesIdKilled.clear()
			spawnPointsUsed.clear()
			spawn_enemies();
