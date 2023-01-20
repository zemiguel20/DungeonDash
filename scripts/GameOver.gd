extends Control


# Called when the node enters the scene tree for the first time.
func game_over(won : bool, time : float):
	get_tree().paused = true
	GameController.add_death_count()
	GameController.add_time(time)
	$DeathCounter.text = "Deaths: %s" % GameController.get_death_count()
	if (won):
		$WinLossLabel.text = "Level Complete!"
	else:
		$TimeDisplay.text = "Time: %.1f" % GameController.get_time()
	visible = true
	$RetryButton.grab_focus()


func _on_RetryButton_pressed():
	$ClickAudio.play()
	$RetryTimer.start()
	$RetryButton.release_focus()
	$RetryButton/Label.margin_top += 2

func _on_RetryTimer_timeout():
	$RetryButton.pressed = false
	$RetryButton/Label.margin_top -= 2
	get_tree().paused = false
	var _error = get_tree().change_scene("res://scenes/Main.tscn")


func _on_MenuButton_pressed():
	$ClickAudio.play()
	$MenuTimer.start()
	$MenuButton.release_focus()
	$MenuButton/Label.margin_top += 2

func _on_MenuTimer_timeout():
	$MenuButton.pressed = false
	$RetryButton/Label.margin_top -= 2
	get_tree().paused = false
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Button_focus_exited():
	$FocusAudio.play()


func _on_mouse_entered(curr : int):
	if (curr == 1):
		$RetryButton.grab_focus()
	elif (curr == 2):
		$MenuButton.grab_focus()
