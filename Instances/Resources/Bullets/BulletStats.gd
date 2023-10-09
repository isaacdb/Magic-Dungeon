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
