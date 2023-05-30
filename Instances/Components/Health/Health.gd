extends Area2D
class_name Health

@export var deathManager : DeathManager
@export var knockBack : KnockBack
@export var lifeBar : HealthBar

@onready var collisionShape := $CollisionShape2D as CollisionShape2D

var lifeBase := 0
var currentHealth := 0
var isActive := true
var usedLayer := 0

signal damage

func _ready():
	monitorable = true
	monitoring = true
	usedLayer = collision_layer
	pass

func SetLifeBase(newLifeBase: float):
	lifeBase = newLifeBase
	currentHealth = lifeBase
	
	if lifeBar:
		lifeBar.SetMaxValue(lifeBase)
	
	pass

func _process(delta):
	pass
	
func SetActive(active: bool):
	isActive = active
	
	collision_layer = usedLayer if active else 0
	collisionShape.set_deferred("Disabled", !active)
	pass

func take_damage(attack: Attack):
	if !isActive:
		return
	
	currentHealth -= attack.damage
	
	if lifeBar:
		lifeBar.UpdateHealthBar(currentHealth)
	
	damage.emit(attack)
		
	if knockBack:
		knockBack.Execute(get_parent(), attack.knock_back, attack.direction)
	
	if (currentHealth <= 0):
		deathManager.Execute()
		
	pass
	
func AddHealth(amount: float):
	currentHealth += amount
	if lifeBar:
		lifeBar.UpdateHealthBar(currentHealth)
	pass
