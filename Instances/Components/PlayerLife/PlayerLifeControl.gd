extends Control

var spaceLeft := 16
var iconWidth := 32

@onready var lifePrefab := preload("res://Instances/Components/PlayerLife/LifeIcon.tscn")

var lifes : Array[LifeIcon]

func _ready():
	Global.set_player_max_life.connect(SetPlayerLife)
	Global.player_hited.connect(RemoveLife)	
	pass


func _process(delta):
#	if Input.is_action_just_pressed("fire"):
#		AddLife()
#
#	if Input.is_action_just_pressed("dash"):
#		RemoveLife()
	pass


func SetPlayerLife(maxLife: int):
	for i in range(maxLife):
		AddLife()
	pass

func AddLife():
	var newLifeIcon = lifePrefab.instantiate() as LifeIcon
	self.call_deferred("add_child", newLifeIcon)
	newLifeIcon.position.x = spaceLeft + iconWidth * lifes.size() * newLifeIcon.scale.x
	lifes.append(newLifeIcon)
	pass
	
func RemoveLife():
	if lifes:
		var lastLife = lifes.back() as LifeIcon
		lifes.erase(lastLife)
		lastLife.Destroy()
	pass
