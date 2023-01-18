extends Node


var menu_music = load("res://assets/music/background_menu_1.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
