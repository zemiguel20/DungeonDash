extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/StartButton.grab_focus()
	MusicController.play_menu_music()


func _on_StartButton_pressed():
	$ClickAudio.play()
	$StartTimer.start()

# Delayed call from on_StartButton_pressed()
func _on_StartTimer_timeout():
	MusicController.stop_music()
	var _error = get_tree().change_scene("res://scenes/LevelSelector.tscn")


func _on_OptionsButton_pressed():
	$ClickAudio.play()
	var _error = get_tree().change_scene("res://scenes/Options.tscn")
	# alternative way:
	#var options = load("res://scenes/Options.tscn").instance()
	#get_tree().current_scene.add_child(options)


func _on_QuitButton_pressed():
	$ClickAudio.play()
	$QuitTimer.start()

# Delayed call from on_QuitButton_pressed()
func _on_QuitTimer_timeout():
	get_tree().quit()


func _on_Button_focus_exited():
	$FocusAudio.play()
