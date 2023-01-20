extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$Level1.grab_focus()


func _on_Level1_pressed():
	$ClickAudio.play()
	$Level1Timer.start()
	GameController.stop_music()
	GameController.set_level(1)

# Delayed call from on_Level1_pressed()
func _on_Level1Timer_timeout():
	var _error = get_tree().change_scene("res://scenes/Main.tscn")


func _on_Level2_pressed():
	$ClickAudio.play()
	$Level2Timer.start()

# Delayed call from on_Level2_pressed()
func _on_Level2Timer_timeout():
	pass # Replace with function body.


func _on_Level3_pressed():
	$ClickAudio.play()
	$Level3Timer.start()
	
# Delayed call from on_Level3_pressed()
func _on_Level3Timer_timeout():
	pass # Replace with function body.


# Back Button
func _on_BackButton_pressed():
	$ClickAudio.play()
	$BackTimer.start()
	$BackButton.release_focus()
	$BackButton/Label.margin_top += 2

# Delayed call from on_BackButton_pressed()
func _on_Timer_timeout():
	$BackButton.pressed = false
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Level_focus_exited(prev : int):
	$FocusAudio.play()
	if (prev == 1):
		$BackButton.focus_neighbour_top = $Level1.get_path()
	elif (prev == 2):
		$BackButton.focus_neighbour_top = $Level2.get_path()
	elif (prev == 3):
		$BackButton.focus_neighbour_top = $Level3.get_path()


func _on_mouse_entered(curr : int):
	if (curr == 1):
		$Level1.grab_focus()
	elif (curr == 2):
		$Level2.grab_focus()
	elif (curr == 3):
		$Level3.grab_focus()
	elif (curr == 0):
		$BackButton.grab_focus()
