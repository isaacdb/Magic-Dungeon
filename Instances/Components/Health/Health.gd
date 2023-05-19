class_name Health

extends Area2D

@export var health := 0
@export var deathManager : DeathManager

var currentHealth := 0

func _ready():
	monitorable = true
	monitoring = false
	
	currentHealth = health	
	pass
	

func _process(delta):
	pass
	

func take_damage(attack: Attack):
	currentHealth -= attack.damage
	
	if (currentHealth <= 0):
		deathManager.Execute()
