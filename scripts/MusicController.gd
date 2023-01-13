extends Node


var menu_music = load("res://assets/music/background_menu_1.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func play_menu_music():
	if (!$Music.playing):
		$Music.stream = menu_music
		$Music.play()

func stop_music():
	$Music.stop()
