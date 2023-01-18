extends Node2D

func activate():
	# swing axe
	$Tween.interpolate_property(
		$AxePivot, 
		"rotation_degrees", 
		0,
		180,
		1,
		Tween.TRANS_BACK)
	$Tween.start()
	$AxeSFX.play()
	$CollisionShape2D.set_deferred("disabled", false)
