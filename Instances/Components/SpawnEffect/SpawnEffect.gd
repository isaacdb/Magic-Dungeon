extends Node2D

var isSpawned := false
var isSpawning := false

@onready var spawnAnimPlayer := $SpawnSprite/AnimationPlayer as AnimationPlayer

func Execute():
	if !isSpawning:
		spawnAnimPlayer.play("Spawn")
		isSpawning = true	

# Chamado no fim da animação
func Spawned():
	print("Spawnou")
	isSpawned = true
