extends MovingObstacle

func activate():
	# Spikes go up
	$Tween.interpolate_property(
		$Sprite, 
		"position", 
		Vector2(0,48),
		Vector2(0,0),
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
	$Tween.start()
	# Play sound
	$SpikeSFX.play()