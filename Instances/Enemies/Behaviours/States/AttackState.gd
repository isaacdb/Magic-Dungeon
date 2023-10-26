extends StateMachineState
class_name AttackState

var sprite : AnimatedSprite2D
var attackManager : AttackManager

var tween : Tween

# Setup methods
func setup_state(_sprite: AnimatedSprite2D, _attackManager: AttackManager) -> void:
	sprite = _sprite;
	attackManager = _attackManager;
	pass
	
func assert_items_requireds() -> void:
	assert(is_instance_valid(sprite), "Sprite missing on Attack State");
	assert(is_instance_valid(attackManager), "Attack manager component is missing on Attack State");
	pass
	
# State methods
func on_enter() -> void:
	assert_items_requireds();
	
	tween = create_tween();
	tween.tween_property(sprite, "scale", Vector2(1, 0.7), 0.4)
	tween.parallel().tween_property(sprite, "position:y", -4, 0.4)
	tween.tween_property(sprite, "scale", Vector2(1, 0.5), 0.1)
	tween.parallel().tween_property(sprite, "position:y", 0, 0.1)
	tween.tween_callback(attack)
	tween.tween_property(sprite, "scale", Vector2(1, 1), 0.3)
	tween.parallel().tween_property(sprite, "position:y", 0, 0.3)
	tween.tween_callback(anim_idle_after_attack)
	tween.play();
	pass

func on_exit() -> void:
	tween.stop();
	tween = null;
	
	sprite.scale = Vector2(1, 1);
	sprite.position = Vector2.ZERO
	pass

# Others methods
func attack():
	if not attackManager.attack_manager_finished.is_connected(end_attack):
		attackManager.attack_manager_finished.connect(end_attack)
	attackManager.Execute();
	pass
	
func end_attack() -> void:
	await get_tree().create_timer(randf()).timeout
	change_state(next_state.name);
	pass
	
func anim_idle_after_attack() -> void:
	tween = create_tween();
	tween.set_loops()
	tween.tween_property(sprite, "scale", Vector2(1.1, 0.9), 0.5).from(Vector2(1, 1))
	tween.tween_property(sprite, "scale", Vector2(1, 1), 0.5)
	tween.play()
	pass
