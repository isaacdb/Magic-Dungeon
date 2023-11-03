extends Resource
class_name BulletStats

@export var damage := 0.0
@export var piercingShots := 0
@export var bounceTimes := 0
@export var knockBackForce := 0.0
@export var speed := 0.0
@export var bulletFireAmount := 1
@export var angleSpread := 10.0
@export_enum("None", "Player", "Enemy") var origin = "None"
@export var prefab := preload("res://Instances/Bullet/Bullet.tscn")
@export var lifeTime := 5.0
@export_enum("Default", "Fire1", "Fire3", "Spinning2") var bulletSpriteAnim := "Default"
@export var follow_player := false
@export var follow_player_weight := 0.02
@export var line_trail_active := true

func ApplyUpgradeDamage(upgradeValue: float):
	var currentDamage = damage
	var newDamage = currentDamage + MathUtil.CalculateValueByPercent(upgradeValue, currentDamage)
	damage = newDamage
	pass

func ApplyUpgradeBounce(upgradeValue) -> void:
	bounceTimes += upgradeValue
	pass
