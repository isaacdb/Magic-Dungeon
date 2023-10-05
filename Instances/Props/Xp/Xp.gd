extends Node2D

@export var playerTracker : PlayerTracker;

@onready var default_pos = self.global_position
@onready var rnd := RandomNumberGenerator.new()

@export var defaultSpeed := 1.0;
@export var explosionSpeed := 4.0;
@export var increaseSpeed := 0.3;

var randExpPosition : Vector2
var navigateToPlayer := false

func _ready() -> void:
	var tweenRotate = create_tween().set_loops()
	tweenRotate.tween_property(self, "rotation_degrees", 360, 3.0).from(0.0)
	rnd.randomize()
	randExpPosition = SpawnExplosion();
	pass
	
func DynamicMoveSpawn(delta: float) -> void:
	if navigateToPlayer:
		defaultSpeed += increaseSpeed;
		position = position.lerp(playerTracker.GetPosition(), delta * defaultSpeed);
		return
		
	position = position.lerp(randExpPosition, delta * explosionSpeed);
	
	if position.distance_to(randExpPosition) <= 1:
		navigateToPlayer = true;
		
	return

func _physics_process(delta) -> void:
	DynamicMoveSpawn(delta);
	
	if playerTracker.GetDistance() < 8.0:
		Collected();
		return
	
func SpawnExplosion() -> Vector2:
	var randPos = Vector2(rnd.randf_range(-1, 1), rnd.randf_range(-1, 1))
	var randVelocty = rnd.randf_range(60, 80);
	var randPosition = randPos * randVelocty;
	return (randPosition + self.global_position)
	
func Collected() -> void:
	if Global.playerIsAlive:
		Global.xp_colleted.emit()
		
	queue_free()
	pass
