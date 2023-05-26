extends Node2D
class_name DampingEffect

## Funcionou, porem não vale apena o esforço
## Muito trabalho para achar os valores ideias, demora muito
## Muito mais facil, rapido usar TWEEN, que fica mt bom tbm

# How much velocity is necessary to move
# Low values the move will be longer and slow
# High values the move will be short and fast
var spring : float

# How much the movement will reduce over time
# Values between 0 and 5 +-
# Zero move is infinite, large values there will no move
var damp : float

var velocity : float
var displacement : float

## Controles adicionados para tentar visualizar e debugar melhor, pra achar os valores ideiais
@onready var dampSlider := $Control/HSlider2Damp
@onready var springSlider := $Control/HSliderSpring
@onready var sliderTest := $Control/SLIDERTEST

var velocityApply : float

func _process(delta):
	if Input.is_action_pressed("dash"):
		velocity = velocityApply
	
	sliderTest.value = CalculateDamping(delta) + sliderTest.max_value / 2

## The SECRET FORMULA for juicy movements / Youtube
func CalculateDamping(delta: float) -> float:
	var force = - spring * displacement + damp * velocity
	velocity -= force * delta
	displacement -= velocity * delta
	return displacement


func _on_h_slider_2_damp_value_changed(value):
	$Control/Label2Damp.text = "DAMP " + str(value)
	damp = value

func _on_h_slider_spring_value_changed(value):
	$Control/LabelSpring.text = "SPRING " + str(value)
	spring = value

func _on_slider_velocity_value_changed(value):
	$Control/LabelVELOCITY.text = "Velocity apply" + str(value)
	velocityApply = value
