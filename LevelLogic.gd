extends Node

signal level_finished
signal player_died

func _player_hit(player):
	player.die()
	emit_signal("player_died")

func _finish_line_reached(_body):
	print("LEVEL FINISHED")
	$Player.set_physics_process(false)
	emit_signal("level_finished")

func restart():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func quit():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
