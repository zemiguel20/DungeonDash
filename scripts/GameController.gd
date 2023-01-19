extends Node


var menu_music = load("res://assets/music/background_menu_1.wav")
var death_count


# Called when the node enters the scene tree for the first time.
func _ready():
	death_count = 0


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
	death_count += 1

func get_death_count():
	return death_count
