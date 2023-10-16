extends Node

## Signals
signal screen_shake

signal player_dead
signal player_hited
signal player_remove_life
signal player_add_life
signal player_fire

signal xp_colleted
signal level_up
signal upgrade_adquired

signal enemy_killed
signal boss_killed
signal enter_boss_room

signal game_start

## Variables
var mouseOverGUI := false
var playerIsAlive := true
var panelUpgradeIsOpen := false
var gameFinished := false
var camera : Camera2D

func CalculeFloatVariation(delta: float, amplitude: float, frequency: float) -> float:
	return (sin(Time.get_ticks_msec() * delta * amplitude) * frequency)
