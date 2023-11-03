extends Node2D

func Execute():
	var enemyBody = get_parent().get_parent();
	assert(enemyBody is CharacterBody2D);
	
	Global.enemy_killed.emit(enemyBody)
	pass
