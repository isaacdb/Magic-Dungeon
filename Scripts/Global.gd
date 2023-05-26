extends Node

signal screen_shake

signal player_dead
signal set_player_max_life
signal player_hited
signal player_add_life

signal xp_colleted
signal level_up

signal enemy_killed
signal boss_killed

var camera : Camera2D


func CalculeFloatVariation(delta: float, amplitude: float, frequency: float) -> float:
	return (sin(Time.get_ticks_msec() * delta * amplitude) * frequency)
