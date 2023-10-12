extends UpgradeStats
class_name ExplodeEnemyUpgrade

var stacks := 0

@export var explosionPrefab : PackedScene
var playerInstance : Mage1

func Apply(player: Mage1):
	if VerifyApliedStacks():
		stacks += 1
		playerInstance = player
		if not Global.enemy_killed.is_connected(CreateExplosion):
			Global.enemy_killed.connect(CreateExplosion)
	pass

func Clean():
	stacks = 0
	playerInstance = null
	Global.enemy_killed.disconnect(CreateExplosion)
	pass

func CreateExplosion(enemyPosition: Node2D) -> void:
	if not is_instance_valid(playerInstance):
		return
		
	var explosion = explosionPrefab.instantiate() as ExplodeCircleBullets
	var bulletParent = enemyPosition.get_tree().get_first_node_in_group("BulletParent");
	explosion.bulletAmount = upgradeValue + (stacks * 2)
	explosion.bullet = playerInstance.weapon.bulletStats.duplicate();
	explosion.bullet.damage /= 2
	explosion.bullet.bulletFireAmount = 1
	bulletParent.add_child(explosion);
	explosion.global_position = enemyPosition.global_position
	pass
