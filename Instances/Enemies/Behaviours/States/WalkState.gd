extends StateMachineState
class_name WalkState

var sprite : AnimatedSprite2D
var speed : float
var moveComponent : MoveComponent
var character : CharacterBody2D
var deslocateToPlayer : DescolateToPlayer
var playerTracker : PlayerTracker
var maxDistanceToWalk : float

var tween : Tween
var nextPosition := Vector2.ZERO

# Setup methods
func setup_state(_sprite: AnimatedSprite2D, _speed: float, _moveComponent: MoveComponent, _character: CharacterBody2D, _deslocateToPlayer: DescolateToPlayer, _playerTracker: PlayerTracker, _maxDistanceToWalk: float) -> void:
	sprite = _sprite;
	speed = _speed;
	moveComponent = _moveComponent;
	character = _character;
	deslocateToPlayer = _deslocateToPlayer;
	playerTracker = _playerTracker;
	maxDistanceToWalk = _maxDistanceToWalk;
	pass
	
func assert_items_requireds() -> void:
	assert(is_instance_valid(sprite), "Sprite is missing on Walk State");
	assert(speed != 0.0, "Speed ver is missing on Walk State");
	assert(is_instance_valid(moveComponent), "Move component is missing on Walk State");
	assert(is_instance_valid(character), "Character is missing on Walk State");
	assert(is_instance_valid(deslocateToPlayer), "Deslocate to Player Component is missing on Walk State");
	assert(is_instance_valid(playerTracker), "Player tracker component is missing on Walk State");
	assert(maxDistanceToWalk != 0.0, "Max distance to walk is missing on Walk State");
	pass

# State methods
func on_enter() -> void:
	assert_items_requireds();
	
	set_next_position();
	
	if !is_instance_valid(tween):
		tween = create_tween();
	tween.set_loops()
	tween.tween_property(sprite, "position", Vector2(0, -1), 0.3)
	tween.parallel().tween_property(sprite, "rotation_degrees", 10, 0.3)
	tween.tween_property(sprite, "position", Vector2(0, 0), 0.3)
	tween.parallel().tween_property(sprite, "rotation_degrees", -10, 0.3)
	tween.play()
	pass

func on_physics_process(_delta: float) -> void:
	if nextPosition.distance_to(character.global_position) < 10:
		change_state(next_state.name);
		
	moveComponent.Move(character, get_direction_to_next_position(), _delta, 1300, speed)
	
	if character.get_slide_collision_count():
		var collision = character.get_slide_collision(0);
		nextPosition = character.global_position + (get_direction_to_next_position().bounce(collision.get_normal()) * 20)
		return
	pass
	
func on_exit() -> void:
	tween.stop();
	tween = null
	sprite.rotation_degrees = 0
	sprite.position = Vector2.ZERO
	pass

# Other methods
func get_direction_to_next_position() -> Vector2:
	return (nextPosition - character.global_position).normalized()

func set_next_position() -> void:
	nextPosition = deslocateToPlayer.GetNextPosition(playerTracker.GetDirection(), get_distance_to_walk(), 45) + character.global_position;
	pass
	
func get_distance_to_walk() -> float:
	if playerTracker.GetDistance() < maxDistanceToWalk:
		return playerTracker.GetDistance()
	
	return  maxDistanceToWalk;
