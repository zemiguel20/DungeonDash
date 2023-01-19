extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$StartButton.grab_focus()
	GameController.play_menu_music()


func _on_StartButton_pressed():
	$ClickAudio.play()
	$StartTimer.start()
	$StartButton.release_focus()
	$StartButton/Label.margin_top += 2

# Delayed call from on_StartButton_pressed()
func _on_StartTimer_timeout():
	$StartButton.pressed = false
	$StartButton/Label.margin_top -= 2
	var _error = get_tree().change_scene("res://scenes/LevelSelector.tscn")


func _on_OptionsButton_pressed():
	$ClickAudio.play()
	$OptionsButton.release_focus()
	$OptionsButton/Label.margin_top += 2
	var _error = get_tree().change_scene("res://scenes/Options.tscn")
	# alternative way:
	#var options = load("res://scenes/Options.tscn").instance()
	#get_tree().current_scene.add_child(options)


func _on_QuitButton_pressed():
	$ClickAudio.play()
	$QuitTimer.start()
	$QuitButton.release_focus()
	$QuitButton/Label.margin_top += 2

# Delayed call from on_QuitButton_pressed()
func _on_QuitTimer_timeout():
	$QuitButton.pressed = false
	$QuitButton/Label.margin_top -= 2
	get_tree().quit()


func _on_Button_focus_exited():
	$FocusAudio.play()


func _on_mouse_entered(curr : int):
	if (curr == 1):
		$StartButton.grab_focus()
	elif (curr == 2):
		$OptionsButton.grab_focus()
	elif (curr == 3):
		$QuitButton.grab_focus()
