extends Node2D

@export var activeHandle : ActiveHandleComponent

@onready var spawnAnimPlayer := $SpawnSprite/AnimationPlayer as AnimationPlayer

var isSpawned := false
var isSpawning := false
var isActive := false


func Execute():
	if !isSpawning:
		spawnAnimPlayer.play("Spawn")
		isSpawning = true
		activeHandle.Execute(false)

# Chamado no fim da animação
func Spawned():
	isSpawned = true
	activeHandle.Execute(true)

func SetActive(active: bool):
	isActive = active
	pass
