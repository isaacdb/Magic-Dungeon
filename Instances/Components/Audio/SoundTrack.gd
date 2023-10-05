extends Node

@onready var audioPlayer := $AudioPlayer as AudioStreamPlayer2D

@export var soundTrackGeneral : AudioStream
@export var bossTrack : AudioStream

func _ready():
	Global.game_start.connect(GameStart)
	Global.enter_boss_room.connect(BossFight)
	Global.player_dead.connect(EndGame)
	Global.boss_killed.connect(EndGame)
	
func PlayStop(play: bool) -> void:
	audioPlayer.playing = play;	
	pass

func GameStart():
	ChangeTrackAndTweenPlay(soundTrackGeneral, -12)
	pass
	
func BossFight():
	TweenStopCurrentTrack(1)
	ChangeTrackAndTweenPlay(bossTrack, 0)
	pass
	
func EndGame():
	TweenStopCurrentTrack(7)
	pass

func ChangeTrackAndTweenPlay(audio: AudioStream, finalVolume: int) -> void:
	if audio == audioPlayer.stream and audioPlayer.playing and finalVolume == audioPlayer.volume_db:
		return
	
	audioPlayer.volume_db = -100
	audioPlayer.stream = audio	
	
	if Settings.music:
		audioPlayer.play()
	
	var tween = create_tween()
	tween.tween_property(audioPlayer, "volume_db", finalVolume, 1)
	tween.play()
	pass
	
func TweenStopCurrentTrack(delay: int) -> void:
	var tweenStopCurrentTrack = create_tween()
	tweenStopCurrentTrack.tween_property(audioPlayer, "volume_db", -30, delay)
	tweenStopCurrentTrack.play()	
	pass
