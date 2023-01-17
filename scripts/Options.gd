extends Control

onready var _masterbus := AudioServer.get_bus_index("Master")
onready var _musicbus  := AudioServer.get_bus_index("Music")
onready var _soundbus  := AudioServer.get_bus_index("SoundEffects")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/GlobalVolumeSlider.grab_focus()
	$VBoxContainer/GlobalVolumeSlider.value = db2linear(AudioServer.get_bus_volume_db(_masterbus))
	$VBoxContainer/MusicSlider.value = db2linear(AudioServer.get_bus_volume_db(_musicbus))
	$VBoxContainer/SoundSlider.value = db2linear(AudioServer.get_bus_volume_db(_soundbus))


# Volume Sliders
func _on_GlobalVolumeSlider_value_changed(value: float):
	$ClickAudio.play()
	AudioServer.set_bus_volume_db(_masterbus, linear2db(value))

func _on_GlobalVolumeSlider_mouse_exited():
	release_focus()

func _on_MusicSlider_value_changed(value: float):
	$ClickAudio.play()
	AudioServer.set_bus_volume_db(_musicbus, linear2db(value))

func _on_SoundSlider_value_changed(value: float):
	$ClickAudio.play()
	AudioServer.set_bus_volume_db(_soundbus, linear2db(value))


func _on_Option_focus_exited():
	$FocusAudio.play()


# Back Button
func _on_BackButton_pressed():
	$ClickAudio.play()
	$Timer.start()
	$BackButton.release_focus()
	$BackButton/Label.margin_top += 2

# Delayed call from on_BackButton_pressed()
func _on_Timer_timeout():
	$BackButton.pressed = false
	var _error = get_tree().change_scene("res://scenes/MainMenu.tscn")


func _on_mouse_entered(curr : int):
	if (curr == 1):
		$VBoxContainer/GlobalVolumeSlider.grab_focus()
	elif (curr == 2):
		$VBoxContainer/MusicSlider.grab_focus()
	elif (curr == 3):
		$VBoxContainer/SoundSlider.grab_focus()
	elif (curr == 0):
		$BackButton.grab_focus()
