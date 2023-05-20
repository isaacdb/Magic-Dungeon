extends Area2D
class_name Health


@export var health := 0
@export var deathManager : DeathManager
@export var knockBack : KnockBack

var currentHealth := 0

signal damage

func _ready():
	monitorable = true
	monitoring = false
	
	currentHealth = health	
	pass
	

func _process(delta):
	pass
	

func take_damage(attack: Attack):
	currentHealth -= attack.damage
	
	damage.emit()
		
	if knockBack:
		knockBack.Execute(get_parent(), attack.knock_back, attack.direction)
	
	if (currentHealth <= 0):
		deathManager.Execute()
