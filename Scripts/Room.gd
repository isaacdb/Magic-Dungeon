extends Node2D

@export var gateEnter : Gate
@export var gateExit : Gate
@export var enemies : Array[PackedScene]
@export var qntdEnemies : Array[int]

@onready var areaRoom := $Area2D as Area2D
@onready var spawnPoints = self.get_node("SpawnPoints").get_children() as Array[Node2D]
@onready var rand = RandomNumberGenerator.new()

var areaClean = false
var areaActive = false
var spawnPointsUsed : Array[int]
var enemiesCount := 0
var enemiesKilled := 0 

func _ready():
	rand.randomize()
	areaRoom.connect("body_entered", area_room_body_entered)
	Global.enemy_killed.connect(enemy_killed)
	pass # Replace with function body.

func area_room_body_entered(body):
	if !areaClean and body.is_in_group("player"):
		areaActive = true
		gateEnter.close()
		spawn_enemies()
	pass
	
func spawn_enemies():
	var enemyNum := 0
	for enemy in enemies:
		for qntd in range(0, qntdEnemies[enemyNum]):
			var newEnemy = enemy.instantiate() as CharacterBody2D
			self.get_parent().call_deferred("add_child", newEnemy)
			newEnemy.global_position = get_random_spawn_point()
			enemiesCount += 1
		
		enemyNum += 1
	pass

func get_random_spawn_point() -> Vector2:
	var positionIndex = rand.randi_range(0, spawnPoints.size() - 1)		
	
	while spawnPointsUsed.any(func(number): return number == positionIndex):
		positionIndex = rand.randi_range(0, spawnPoints.size() -  1)		
	
	spawnPointsUsed.insert(0, positionIndex)
	
	return spawnPoints[positionIndex].global_position
	
func enemy_killed():
	if areaActive and not areaClean:
		enemiesKilled += 1
	
		if enemiesKilled >= enemiesCount:
			gateExit.open()
			gateEnter.open() 
			areaActive = false
			areaClean = true
