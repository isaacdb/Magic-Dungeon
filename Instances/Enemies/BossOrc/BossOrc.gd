extends EnemyBase

@onready var smashPoints = self.get_parent().get_node("SmashPoints").get_children() as Array[Node2D]
@onready var lowOrc := preload("res://Instances/Enemies/LowOrc/LowOrc.tscn")
@onready var rnd := RandomNumberGenerator.new()

var canAttack = false
var currentSmashPoints : Array[int]
var qntdSmashForAttack := 2
var rageMode := false

func _ready():	
	rnd.randomize()
	currentSmashPoints.insert(0, 0)
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
			pass
			
		States.CHASING:
			pass
	
		States.ATTACK:
			if canAttack:
				canAttack = false
				
				var qntdSmashs = qntdSmashForAttack
				var smashVelocity = 1
				var smashDelay = 3.5
				
				if rageMode:
					qntdSmashs += 2
					smashVelocity = 0.6
					smashDelay = 1.5				
				
				for i in qntdSmashs:
					_chose_where_smash()
				
				var tween = create_tween()				
				for i in qntdSmashs:
					tween.tween_property(self, "global_position", smashPoints[currentSmashPoints[i - 1]].global_position, smashVelocity)
				
				
				tween.connect("finished", _smash_end)
				tween.play()
				
				enemyAttackTimer.wait_time = smashDelay				
				
				_clean_current_smash_points()
				currentState = States.IDLE
			pass
			
		States.HIT:
			animPlayer.play("Hit")
			Global.emit_signal("screen_shake", 1, .1, 1)
			
			if currentLife <= lifeBase / 2:
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

func _smash_end():
	enemyAttackTimer.start()
	print("start delay")
	pass

func _on_timer_attack_timeout():
	canAttack = true
	currentState = States.ATTACK
	pass

func _spawn_low_orcs():
	animPlayer.play("SpawnLowOrcs")
		
	var newLowOrc = lowOrc.instantiate()
	get_tree().get_root().get_child(0).add_child(newLowOrc)
	newLowOrc.global_position = global_position
	
	pass

func _on_hit_knock_back_timer_timeout():
	print("Knockacktimer")
	pass 
	
func _chose_where_smash():
	var rndSmashIndex = rnd.randi_range(0, smashPoints.size() - 1)
	
	while currentSmashPoints.any(func(number): return number == rndSmashIndex):
		rndSmashIndex = rnd.randi_range(0, smashPoints.size() - 1)
	
	currentSmashPoints.insert(currentSmashPoints.size(), rndSmashIndex)
	
func _clean_current_smash_points():
	var lastSmashPoint = currentSmashPoints[currentSmashPoints.size() - 1]
	currentSmashPoints.clear()
	currentSmashPoints.insert(0, lastSmashPoint)
