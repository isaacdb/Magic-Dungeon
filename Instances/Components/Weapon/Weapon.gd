extends Node2D
class_name Weapon

@export var fireRate := 0.6;
@export var ammunitionAmount := 6;
@export var reloadTime := 2.0;
@export var bulletStats : BulletStats

@onready var shooterComponent := $WeaponRoundComponent/ShooterComponent as ShooterComponent
@onready var sprite := $WeaponRoundComponent/Sprite2D as Sprite2D
@onready var reloadTimer := $Timer as Timer
@onready var progressReload := $ProgressBar as ProgressBar

var currentAmmunitionAmount := 0;

func _ready():
	currentAmmunitionAmount = ammunitionAmount;
	progressReload.visible = false
	Global.player_fire.emit(currentAmmunitionAmount)
	
	SetupFireRate(fireRate);
	SetupReloadTime(reloadTime);
	reloadTimer.set_one_shot(true)
	reloadTimer.connect("timeout", RealodComplete)
	pass

func SetupFireRate(newFireRate: float) -> void:
	fireRate = newFireRate
	if shooterComponent:
		shooterComponent.UpdateFireRate(fireRate);
	pass
	
func SetupFireRateBoost(boostedFireRate: float):
	if shooterComponent:
		shooterComponent.UpdateFireRate(boostedFireRate);
	pass
	
func SetupReloadTime(newReloadTime: float) -> void:
	reloadTime = newReloadTime;
	if reloadTimer:
		reloadTimer.wait_time = newReloadTime;
	pass	

func _physics_process(delta):
	sprite.position.y = Global.CalculeFloatVariation(delta, 0.15, 1.5)
	pass

func PlayAnimFire():
	var tween = create_tween()
	tween.tween_property(sprite, "position:x", -5, 0.2).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_property(sprite, "position:x", 0, 0.3).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.play()

func Fire(direction: Vector2) -> void:
	if currentAmmunitionAmount <= 0:
		return;
	
	var shoot = shooterComponent.FireWithCooldown(direction, bulletStats)
	if shoot:
		currentAmmunitionAmount -= 1;
		Global.player_fire.emit(currentAmmunitionAmount)
		
		if currentAmmunitionAmount <= 0:
			ReloadStart()
			
		Global.emit_signal("screen_shake", 1, .1, 1)
		PlayAnimFire();
	pass

func GetSpawnPoint() -> Vector2:
	return shooterComponent.global_position;
	
func ReloadStart() -> void:
	progressReload.value = 0;
	progressReload.visible = true;
	
	var tween = create_tween()
	tween.tween_property(progressReload, "value", 100, reloadTimer.wait_time)
	tween.tween_property(progressReload, "visible", false, 0)
	tween.play();
	
	reloadTimer.start()
	pass

func RealodComplete() -> void:
	currentAmmunitionAmount = ammunitionAmount
	Global.player_fire.emit(currentAmmunitionAmount)
	pass
