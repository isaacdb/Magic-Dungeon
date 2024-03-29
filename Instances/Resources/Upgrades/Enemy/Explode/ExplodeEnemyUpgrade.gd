extends UpgradeStats
class_name ExplodeEnemyUpgrade

@export var explosionPrefab : PackedScene
var playerInstance : Mage1

var enemyIdExplodedList : Array[int] = []

func Apply(player: Mage1):
	if VerifyApliedStacks():
		playerInstance = player
		if not Global.enemy_killed.is_connected(CreateExplosion):
			Global.enemy_killed.connect(CreateExplosion)
	pass

func Clean():
	super.Clean();
	playerInstance = null;
	enemyIdExplodedList.clear();
	Global.enemy_killed.disconnect(CreateExplosion);
	pass

func CreateExplosion(enemy: CharacterBody2D) -> void:
	if not is_instance_valid(playerInstance):
		return
	
	if enemyIdExplodedList.find(enemy.get_instance_id()) != -1:
		return
		
	enemyIdExplodedList.append(enemy.get_instance_id());
		
	var explosion = explosionPrefab.instantiate() as ExplodeCircleBullets
	explosion.bulletAmount = upgradeValue + (upgradeStack * 2)
	explosion.bullet = playerInstance.weapon.bulletStats.duplicate();
	explosion.bullet.damage /= 2
	explosion.bullet.bulletFireAmount = 1
	
	var bulletParent = enemy.get_tree().get_first_node_in_group("BulletParent");
	bulletParent.add_child(explosion);
	
	explosion.global_position = enemy.global_position
	pass
