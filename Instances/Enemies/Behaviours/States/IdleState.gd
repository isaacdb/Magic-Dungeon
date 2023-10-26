extends StateMachineState
class_name IdleState

var time_idle := 0.0
var sprite : AnimatedSprite2D

var timer : Timer
var tween : Tween

# Setup methods
func setup_state(_time_idle: float, _sprite: AnimatedSprite2D) -> void:
	time_idle = _time_idle;
	sprite = _sprite;
	pass
	
func assert_items_requireds() -> void:
	var enemy = get_parent().get_parent().name;
	assert(is_instance_valid(sprite), "Sprite missing on Idle State" + enemy);
	assert(time_idle != 0.0, "Time idle var is missing on Idle State");
	pass
	
# State methods
func on_enter() -> void:
	assert_items_requireds();
	if !is_instance_valid(timer):
		timer = Timer.new()
		add_child(timer)
		timer.one_shot = true
		timer.autostart = false
		
	tween = create_tween();
	tween.set_loops()
	tween.tween_property(sprite, "scale", Vector2(1.1, 0.9), 0.5).from(Vector2(1, 1))
	tween.tween_property(sprite, "scale", Vector2(1, 1), 0.5)
	tween.play()
	
	timer.wait_time = time_idle + randf()
	timer.start();
	if not timer.timeout.is_connected(on_timer_timeout):
		timer.timeout.connect(on_timer_timeout)
	pass

func on_exit() -> void:
	if is_instance_valid(timer):
		timer.stop();
		timer.timeout.disconnect(on_timer_timeout);
	
	if is_instance_valid(tween):
		tween.stop();
		tween = null;
	
	if is_instance_valid(sprite):
		sprite.scale = Vector2(1, 1);
	pass

# Others methods
func on_timer_timeout() -> void:
	change_state(next_state.name)
	pass
