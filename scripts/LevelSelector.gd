extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/Level1.grab_focus()


func _on_Level1_pressed():
	$ClickAudio.play()
	$Level1Timer.start()

# Delayed call from on_Level1_pressed()
func _on_Level1Timer_timeout():
	var _error = get_tree().change_scene("res://scenes/Main.tscn")


func _on_Level2_pressed():
	$ClickAudio.play()
	$Level2Timer.start()

# Delayed call from on_Level2_pressed()
func _on_Level2Timer_timeout():
	pass # Replace with function body.


# Back Button
func _on_BackButton_pressed():
	$ClickAudio.play()
	$BackTimer.start()

# Delayed call from on_BackButton_pressed()
func _on_Timer_timeout():
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_Level_focus_exited(prev : int):
	$FocusAudio.play()
	if (prev == 1):
		$VBoxContainer/BackButton.focus_neighbour_top = $VBoxContainer/HBoxContainer/Level1.get_path()
	elif (prev == 2):
		$VBoxContainer/BackButton.focus_neighbour_top = $VBoxContainer/HBoxContainer/Level2.get_path()
