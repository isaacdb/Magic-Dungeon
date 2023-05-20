extends Area2D
class_name Health


@export var health := 0
@export var deathManager : DeathManager
@export var knockBack : KnockBack

@onready var collisionShape := $CollisionShape2D as CollisionShape2D

var currentHealth := 0
var isActive := false

signal damage

func _ready():
	monitorable = true
	monitoring = true
	
	currentHealth = health	
	pass
	

func _process(delta):
	pass
	
func SetActive(active: bool):
	isActive = active
	
	collisionShape.set_deferred("Disabled", !active)
	pass

func take_damage(attack: Attack):
	if !isActive:
		return
	
	currentHealth -= attack.damage
	
	damage.emit()
		
	if knockBack:
		knockBack.Execute(get_parent(), attack.knock_back, attack.direction)
	
	if (currentHealth <= 0):
		deathManager.Execute()
