extends StateMachineState
class_name ChasePlayerState

var sprite : AnimatedSprite2D
var speed : float
var moveComponent : MoveComponent
var character : CharacterBody2D
var playerTracker : PlayerTracker
var time_chasing := 0.0

var timer : Timer
var tween : Tween
const msg_assert = " is missing on Chase Player State"

# Setup methods
func setup_state(_sprite: AnimatedSprite2D, _speed: float, _moveComponent: MoveComponent, _character: CharacterBody2D, _playerTracker: PlayerTracker, _time_chasing: float) -> void:
	sprite = _sprite;
	speed = _speed;
	moveComponent = _moveComponent;
	character = _character;
	playerTracker = _playerTracker;
	time_chasing = _time_chasing;
	pass
	
func assert_items_requireds() -> void:
	assert(is_instance_valid(sprite), "Sprite" + msg_assert);
	assert(speed != 0.0, "Speed var" + msg_assert);
	assert(is_instance_valid(moveComponent), "Move component" + msg_assert);
	assert(is_instance_valid(character), "Character" + msg_assert);
	assert(is_instance_valid(playerTracker), "Player tracker component" + msg_assert);
	assert(time_chasing != 0.0, "Time chasing var" + msg_assert);	
	pass

# State methods
func on_enter() -> void:
	assert_items_requireds();
	
	tween = create_tween();
	tween.set_loops()
	tween.tween_property(sprite, "position", Vector2(0, -1), 0.3)
	tween.parallel().tween_property(sprite, "rotation_degrees", 10, 0.3)
	tween.tween_property(sprite, "position", Vector2(0, 0), 0.3)
	tween.parallel().tween_property(sprite, "rotation_degrees", -10, 0.3)
	tween.play()
	
	if !is_instance_valid(timer):
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
	
	timer.wait_time = time_chasing + randf()
	timer.start();
	if not timer.timeout.is_connected(on_timer_chasing_timeout):
		timer.timeout.connect(on_timer_chasing_timeout)
	pass

func on_physics_process(_delta: float) -> void:
	if playerTracker.GetDistance() < 5.0:
		change_state("IdleState")
		return
		
	moveComponent.Move(character, playerTracker.GetDirection(), _delta, 1300, speed)			
	pass
	
func on_exit() -> void:
	timer.stop();
	timer.timeout.disconnect(on_timer_chasing_timeout);
	
	tween.stop();
	tween = null
	
	sprite.rotation_degrees = 0
	sprite.position = Vector2.ZERO
	pass

# Other methods
func on_timer_chasing_timeout() -> void:
	change_state(next_state.name)
	pass
