extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		_on_ReturnButton_pressed()


func _on_MenuButton_pressed():
	$ClickAudio.play()
	$Timer.start()
	$MenuButton.release_focus()
	$MenuButton/Label.margin_top += 2

# Delayed call from on_MenuButton_pressed()
func _on_Timer_timeout():
	$MenuButton.pressed = false
	get_tree().paused = false
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_ReturnButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = not get_tree().paused
	visible = new_pause_state
	$ReturnButton.grab_focus()


func _on_Button_focus_exited():
	$FocusAudio.play()


func _on_mouse_entered(curr : int):
	if (curr == 1):
		$ReturnButton.grab_focus()
	elif (curr == 2):
		$MenuButton.grab_focus()
