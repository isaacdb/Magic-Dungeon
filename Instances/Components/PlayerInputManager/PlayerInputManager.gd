extends Node2D
class_name PlayerInputManager

# Define a quantidade máxima de imprecisão em graus
var maxImprecisionDegrees := 10;
var rand := RandomNumberGenerator.new()

func _ready() -> void:
	rand.randomize();
	pass

func GetAxisInput() -> Vector2:
	var directionH = Input.get_action_strength("move_right") - Input.get_action_strength("move_left");
	var directionV = Input.get_action_strength("move_down") - Input.get_action_strength("move_up");
	
	return Vector2 (directionH, directionV).normalized();
	
func GetMouseDirection(positionRef: Vector2) -> Vector2:
	var direction = (get_global_mouse_position() - positionRef).normalized();
	
	if GetAxisInput() != Vector2.ZERO:
		return AddImprecision(direction);
	else:
		return direction;
	
	pass
	
func AddImprecision(direction: Vector2) -> Vector2:
	var imprecisionAngleVector = rand.randf_range(-maxImprecisionDegrees, maxImprecisionDegrees)

	var imprecisionAngleRadians = deg_to_rad(imprecisionAngleVector)
	return direction.rotated(imprecisionAngleRadians)
