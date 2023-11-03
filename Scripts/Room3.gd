extends Node2D

@export var gateExit : Gate
@export var audioPlayer : AudioStreamPlayer2D

@onready var rand = RandomNumberGenerator.new()
@onready var spawn_area_collider = $SpawnArea/SpawnAreaCollider as CollisionShape2D

var spawnAlert = preload("res://Instances/Components/SpawnEffect/SpawnEffect.tscn")

var areaClean = false
var spawnPointsUsed : Array[int]
var enemiesCount := 0
var enemiesIdKilled : Array[int]
var difficultAmount : float

func _ready():
	self.add_to_group("Room")
	rand.randomize();
	difficultAmount = ProgressManager2.GetDifficultAmount();
	Global.enemy_killed.connect(enemy_killed);
	spawn_enemies();
	pass
	
func spawn_enemies() -> void:
	var currentDifficult := 0.0;
	
	while currentDifficult < difficultAmount:
		var enemyImpact = ProgressManager2.get_random_enemy_impact() as EnemyImpact;
		var newSpawn = spawnAlert.instantiate() as SpawnAlert
		self.call_deferred("add_child", newSpawn)
		newSpawn.objectToSpawn = enemyImpact.enemy
		newSpawn.global_position = get_random_spawn_point()
		currentDifficult += enemyImpact.impact
		enemiesCount += 1
		pass
	pass

func get_random_spawn_point() -> Vector2:
	var spawn_collider_position = spawn_area_collider.global_position;
	var half_size = spawn_area_collider.shape.size / 2 as Vector2
	var rand_x = rand.randf_range(spawn_collider_position.x - half_size.x, spawn_collider_position.x + half_size.x)
	var rand_y = rand.randf_range(spawn_collider_position.y - half_size.y, spawn_collider_position.y + half_size.y)
	
	return Vector2(rand_x, rand_y)
	
func enemy_killed(enemy: CharacterBody2D) -> void:
	if enemiesIdKilled.find(enemy.get_instance_id()) != -1:
		return
		
	enemiesIdKilled.append(enemy.get_instance_id());
	
	if enemiesIdKilled.size() >= enemiesCount:
		gateExit.open();
		areaClean = true;
		Global.room_cleared.emit();
		audioPlayer.play();
