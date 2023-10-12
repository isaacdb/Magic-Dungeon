extends Node

func _ready():
	Global.player_dead.connect(DestroyBulletsPlayer);
	Global.boss_killed.connect(DestroyBulletsEnemies);
	pass

func DestroyBulletsPlayer() -> void:
	var bullets = get_children() as Array[Bullet]
	for i in bullets:
		if i.IsOriginPlayer():
			i.queue_free()
	pass
	
func DestroyBulletsEnemies() -> void:
	var bullets = get_children() as Array[Bullet]
	for i in bullets:
		if i.IsOriginEnemy():
			i.queue_free()	
	pass
