extends Node


var menu_music = load("res://assets/music/background_menu_1.wav")
var death_count = [0, 0, 0]
var total_time = [0.0, 0.0, 0.0]
var currLevel = 1


func play_menu_music():
	if (!$Music.playing):
		$Music.stream = menu_music
		$Music.play()
		$VideoPlayer.play()
		$VideoPlayer.visible = true
		$Background.visible = true


func stop_music():
	$Music.stop()
	$VideoPlayer.stop()
	$Background.visible = false
	$VideoPlayer.visible = false


func _on_VideoPlayer_finished():
	$VideoPlayer.play()


func add_death_count():
	death_count[currLevel - 1] += 1

func get_death_count():
	return death_count[currLevel - 1]


func add_time(time : float):
	total_time[currLevel - 1] += time

func get_time():
	return total_time[currLevel - 1]


func set_level(level : int):
	currLevel = level

func get_level():
	return currLevel
