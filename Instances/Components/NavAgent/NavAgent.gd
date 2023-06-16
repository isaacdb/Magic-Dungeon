extends NavigationAgent2D
class_name MyNavAgent

@export var checkTime := 1.0
@export var targetPosition : Vector2

var _currentCheckTime := 0.0

func _ready() -> void:
	pass

func _physics_process(delta) -> void:
	_currentCheckTime += delta
	if _currentCheckTime > checkTime:
		MakePath()
		_currentCheckTime = 0
	get_next_path_position()
	pass
	
func GetDirectionPath() -> Vector2:
	return (get_next_path_position() - get_parent().global_position).normalized()

func SetTargetPosition(setPosition: Vector2) -> void:
	targetPosition = setPosition
	MakePath()
	pass

func MakePath() -> void:
	target_position = targetPosition
	pass
