extends CanvasLayer

signal restart_pressed
signal quit_pressed

func _on_Restart_pressed():
	emit_signal("restart_pressed")

func _on_Quit_pressed():
	emit_signal("quit_pressed")

func enable():
	visible = true
