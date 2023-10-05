extends Node2D

@export var gateExit : Gate
@export var spawnAlert : PackedScene
@export var audioPlayer : AudioStreamPlayer2D

@onready var spawnPoints = self.get_node("SpawnPoints").get_children() as Array[Node2D]
@onready var rand = RandomNumberGenerator.new()

var enemyPack : EnemyPack

var areaClean = false
var spawnPointsUsed : Array[int]
var enemiesCount := 0
var enemiesKilled := 0 
var waveCount := 0

func _ready():
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
		var randEnemyPack = ProgressManager.GetRandomEnemyPack();
		enemyPack = ResourceLoader.load("res://Instances/Resources/EnemiesPack/Nivel1/Pack" + str(randEnemyPack) + ".tres");
	pass

func area_room_area_entered():
	if Settings.soundEffect:
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
	
func enemy_killed() -> void:
	enemiesKilled += 1
	
	if enemiesKilled >= enemiesCount:
		if waveCount >= enemyPack.waveAmount:
			gateExit.open()
			areaClean = true
			
			if Settings.soundEffect:
				audioPlayer.play()
		else:
			enemiesKilled = 0
			enemiesCount = 0
			spawnPointsUsed.clear()
			spawn_enemies()
