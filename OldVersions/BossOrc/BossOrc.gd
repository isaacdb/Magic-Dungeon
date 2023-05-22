extends EnemyBase

@onready var lowOrc := preload("res://Instances/Enemies/LowOrcN/LowOrcN.tscn")

var canAttack = false
var rageMode := false

func _ready():	
	set_collision_mask_value(4, false) # Dont watch another enemies	
	enable_disable_enemy(false)
	currentLife = lifeBase
	currentState = States.SPAWNING
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
			var currentSpeed = speed
			if rageMode:
				currentSpeed = speed * 1.5
				
			animPlayer.play("Walk")
			var playerDirection = (player.global_position - self.global_position).normalized()
			velocity = velocity.move_toward(playerDirection * currentSpeed, delta * 1300)
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
			Global.emit_signal("screen_shake", 1, .1, 1)
			if currentLife <= lifeBase / 2:
				sprite.modulate = Color(0.862745, 0.0784314, 0.235294, 1)
				rageMode = true
			
			if currentLife <= 0:
				currentState = States.DEATH
		
		States.DEATH:
			Global.emit_signal("screen_shake", 4, 2, 1)
			Global.emit_signal("boss_killed")
			explosionAnimPlayer.play("Explosion")
			explosionAnimPlayer.get_parent().reparent(get_tree().get_root())
			queue_free()
			pass
		
	pass

func _attack():
	player.take_damage(damage, global_position)
	animPlayer.play("Attack")
	pass
	
func _on_timer_attack_timeout():
	canAttack = true
	pass

func _spawn_low_orcs():
	animPlayer.play("SpawnLowOrcs")
		
	var newLowOrc = lowOrc.instantiate()
	get_tree().get_root().get_child(0).add_child(newLowOrc)
	newLowOrc.global_position = global_position
	
	pass

func _on_hit_knock_back_timer_timeout():
	currentState = States.IDLE
	pass 

func attack_anim_finished():
	currentState = States.IDLE
	pass
