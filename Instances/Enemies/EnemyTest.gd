extends EnemyBase

var canAttack = false

func _ready():	
	pass


func _physics_process(delta):
	var playerDirection = (player.global_position - self.global_position).normalized()
	var velocity = speed * playerDirection * delta	
	translate(velocity)
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
	pass
