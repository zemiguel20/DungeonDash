extends MovingObstacle

func activate():
	# swing axe
	$Tween.interpolate_property(
		$AxePivot, 
		"rotation_degrees", 
		0,
		180,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
	$Tween.start()
	$AxeSFX.play()
	$CollisionShape2D.set_deferred("disabled", false)


func _on_Tween_tween_completed(_object, _key):
	$CollisionShape2D.set_deferred("disabled", true)
