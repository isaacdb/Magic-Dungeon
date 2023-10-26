extends StateMachineState
class_name WalkAndFireState

var sprite : AnimatedSprite2D
var speed : float
var move_component : MoveComponent
var character : CharacterBody2D
var player_tracker : PlayerTracker
var time_walking : float
var delay_fire : float
var attack_manager : AttackManager
var group_to_flip: Node2D

var tween : Tween
var timer_walking : Timer
var timer_firing : Timer
var direction := Vector2.ZERO

# Setup methods
func setup_state(_sprite: AnimatedSprite2D, _speed: float, _move_component: MoveComponent, _character: CharacterBody2D, _player_tracker: PlayerTracker, _time_walking: float, _delay_fire: float, _attack_manager: AttackManager, _group_to_flip: Node2D) -> void:
	sprite = _sprite;
	speed = _speed;
	move_component = _move_component;
	character = _character;
	player_tracker = _player_tracker;
	time_walking = _time_walking;
	delay_fire = _delay_fire;
	attack_manager = _attack_manager;
	group_to_flip = _group_to_flip;
	pass
	
func assert_items_requireds() -> void:
	assert(is_instance_valid(sprite), "Sprite is missing on Walk And Fire State");
	assert(speed != 0.0, "Speed ver is missing on Walk And Fire State");
	assert(is_instance_valid(move_component), "Move component is missing on Walk And Fire State");
	assert(is_instance_valid(character), "Character is missing on Walk And Fire State");
	assert(is_instance_valid(player_tracker), "Player tracker component is missing on Walk And Fire State");
	assert(is_instance_valid(attack_manager), "Attack Manager is missing on Walk And Fire State");
	assert(is_instance_valid(group_to_flip), "Group to flip is missing on Walk And Fire State");
	assert(time_walking != 0.0, "Time walinkg is missing on Walk And Fire State");
	assert(delay_fire != 0.0, "Delay firing is missing on Walk And Fire State");
	pass

# State methods
func on_enter() -> void:
	assert_items_requireds();
	
	set_next_direction();
	flip_sprite_to_direction();
	
	tween = create_tween();
	tween.set_loops()
	tween.tween_property(sprite, "position", Vector2(0, -1), 0.3)
	tween.parallel().tween_property(sprite, "rotation_degrees", 10, 0.3)
	tween.tween_property(sprite, "position", Vector2(0, 0), 0.3)
	tween.parallel().tween_property(sprite, "rotation_degrees", -10, 0.3)
	tween.play()
	
	if !is_instance_valid(timer_walking):
		timer_walking = Timer.new()
		add_child(timer_walking)
		timer_walking.one_shot = true
		timer_walking.autostart = false
	
	timer_walking.wait_time = time_walking + randf()
	timer_walking.start();
	if not timer_walking.timeout.is_connected(on_timer_walking_timeout):
		timer_walking.timeout.connect(on_timer_walking_timeout)
	
	
	if !is_instance_valid(timer_firing):
		timer_firing = Timer.new()
		add_child(timer_firing)
		timer_firing.one_shot = false
		timer_firing.autostart = false
	
	timer_firing.wait_time = delay_fire
	timer_firing.start();
	if not timer_firing.timeout.is_connected(on_timer_firing_timeout):
		timer_firing.timeout.connect(on_timer_firing_timeout)
	
	pass

func on_physics_process(_delta: float) -> void:		
	move_component.Move(character, direction, _delta, 1300, speed)
	
	if character.get_slide_collision_count():
		var collision = character.get_slide_collision(0);
		direction = direction.bounce(collision.get_normal())
		flip_sprite_to_direction();
		return
	pass
	
func on_exit() -> void:
	timer_walking.stop();
	timer_walking.timeout.disconnect(on_timer_walking_timeout)
	
	timer_firing.stop();
	timer_firing.timeout.disconnect(on_timer_firing_timeout)
	
	tween.stop();
	tween = null
	
	sprite.rotation_degrees = 0
	sprite.position = Vector2.ZERO
	pass

# Other methods
func set_next_direction() -> void:
	direction = player_tracker.GetDirection();
	pass
	
func on_timer_walking_timeout() -> void:
	change_state(next_state.name)
	pass
	
func on_timer_firing_timeout() -> void:
	attack_manager.Execute();
	pass
	
func flip_sprite_to_direction() -> void:
	if direction.x > 0:
		group_to_flip.scale.x = -1 * sign(group_to_flip.scale.y)
	elif direction.x < 0:
		group_to_flip.scale.x = 1 * sign(group_to_flip.scale.y)
	pass
