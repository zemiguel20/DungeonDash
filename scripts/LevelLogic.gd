extends Node


func _player_died():
	_stop_all_movement()
	$CanvasLayer/Pause.disable_pausing()
	$DeathTimer.start()

func _level_finished():
	_stop_all_movement()
	$CanvasLayer/Pause.disable_pausing()
	print("LEVEL FINISHED")
	_on_game_over(true)

func _stop_all_movement():
	# TODO: Might need to change how to reference the obstacle manager
	for node in $ObstacleHandler.obstacles:
		node.constant_linear_velocity = Vector2.ZERO
	$Environment.speed = 0

func _on_game_over(finished : bool):
	var time = $ObstacleHandler/Song.get_playback_position()
	time += AudioServer.get_time_since_last_mix() 
	time -= AudioServer.get_output_latency()
	time -= $DeathTimer.wait_time
	$CanvasLayer/GameOver.game_over(finished, time)
