extends Control

func _input(event):
	if event.is_action_pressed("pause"):
		_on_ReturnButton_pressed()


func _on_MenuButton_pressed():
	$ClickAudio.play()
	$Timer.start()

# Delayed call from on_BackButton_pressed()
func _on_Timer_timeout():
	get_tree().paused = false
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_ReturnButton_pressed():
	var new_pause_state = not get_tree().paused
	get_tree().paused = not get_tree().paused
	visible = new_pause_state
	$VBoxContainer/ReturnButton.grab_focus()


func _on_Button_focus_exited():
	$FocusAudio.play()
