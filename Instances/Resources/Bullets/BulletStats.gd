extends Resource
class_name BulletStats

@export var damage := 0.0
@export var knockBackForce := 0.0
@export var speed := 0.0
@export_enum("None", "Player", "Enemy") var origin = "None"
@export var prefab := preload("res://Instances/Bullet/BulletsEnemies/BulletEnemy1/BulletN.tscn")
