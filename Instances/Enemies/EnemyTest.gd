extends EnemyBase

var canAttack = false

func _ready():	
	currentLife = lifeBase
	pass


func _physics_process(delta):
	if canAttack:
		return
		
	var playerDirection = (player.global_position - self.global_position).normalized()
	#velocity = velocity.lerp(player.global_position, minf(20 * delta, 1.0))
	velocity = velocity.move_toward(playerDirection * speed, delta * 1300)
	move_and_slide()
	sprite.flip_h = velocity.x < 0
	pass

func _on_attack_area_body_entered(body):
	canAttack = true
	pass

func _on_attack_area_body_exited(body):
	canAttack = false
	pass

func _on_timer_attack_timeout():
	if canAttack:
		_attack()
	pass

func _attack():
	player.take_damage(damage)
	animPlayer.play("Attack")
	pass
