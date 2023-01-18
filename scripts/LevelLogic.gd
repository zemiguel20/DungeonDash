extends Node

signal level_finished
signal player_died

# TODO: FinishLine might be changed to signal when song finished

func _on_player_collision(other_body: CollisionObject2D):
	if other_body.get_collision_layer_bit(1):
		_player_died()
	elif other_body.get_collision_layer_bit(3):
		_finish_line_reached()

func _player_died():
	_stop_all_movement()
	$Player.die()
	emit_signal("player_died")

func _finish_line_reached():
	_stop_all_movement()
	print("LEVEL FINISHED")
	emit_signal("level_finished")

func _stop_all_movement():
	# TODO: Might need to change how to reference the obstacle manager
	for node in $ObstacleHandler.obstacles:
		node.constant_linear_velocity = Vector2.ZERO
	$FinishLine.constant_linear_velocity = Vector2.ZERO

func restart():
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()

func quit():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://scenes/MainMenu.tscn")
