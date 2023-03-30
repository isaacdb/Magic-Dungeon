extends EnemyAttack
class_name EnemyMeleAttack

func attack(enemyBase: EnemyBase):
	enemyBase.player.take_damage(enemyBase.enemyBaseResource.damage)
	enemyBase.animPlayer.play("Attack")
	pass
