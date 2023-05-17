extends EnemyBase

var canAttack = false

func _ready():	
	enable_disable_enemy(false)
	currentLife = lifeBase
	pass

func _physics_process(delta):
	match currentState:
		States.SPAWNING:
			pass
			
		States.IDLE:
			animPlayer.play("Walk")
			sprite.rotation_degrees = 0
			var circleAreaAttack = attackAreaShape.shape as CircleShape2D
			if circleAreaAttack.radius <= self.global_position.distance_to(player.global_position):
				currentState = States.CHASING
				return
				
			if canAttack and circleAreaAttack.radius > self.global_position.distance_to(player.global_position):
				currentState = States.ATTACK
				
			pass
			
		States.CHASING:
			animPlayer.play("Walk")
			var playerDirection = (player.global_position - self.global_position).normalized()
			velocity = velocity.move_toward(playerDirection * speed, delta * 1300)
			move_and_slide()
	
			sprite.flip_h = playerDirection.x < 0
			var circleAreaAttack = attackAreaShape.shape as CircleShape2D
			if circleAreaAttack.radius > self.global_position.distance_to(player.global_position):
				currentState = States.IDLE
			pass
	
		States.ATTACK:
			if canAttack:
				_attack()
				canAttack = false
				enemyAttackTimer.start()			
			pass
			
		States.HIT:
			animPlayer.play("Hit")
			Global.emit_signal("screen_shake", .5, .1, 1)
			
			velocity = lastBulletImpactDirection * 100
			sprite.rotation_degrees = lastBulletImpactDirection.x * 45
			move_and_slide()
			
			if currentLife <= 0:
				currentState = States.DEATH
		
		States.DEATH:
			Global.emit_signal("screen_shake", 2, .2, .5)
			Global.emit_signal("enemy_killed")
			explosionAnimPlayer.play("Explosion")
			explosionAnimPlayer.get_parent().reparent(get_tree().get_root())
			queue_free()
			pass

	pass

func _on_timer_attack_timeout():
	canAttack = true
	pass

func _attack():
	player.take_damage(damage, global_position)
	animPlayer.play("Attack")
	pass

func _on_hit_knock_back_timer_timeout():
	currentState = States.IDLE
	pass 
	
func attack_anim_finished():
	currentState = States.IDLE
	pass
