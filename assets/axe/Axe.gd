extends Node2D

signal axe_hit

func _on_Trigger_body_entered(_body):
	print("Player triggered axe")
	# Spikes up Tween spikes offset
	$Tween.interpolate_property(
		$AxePivot, 
		"rotation_degrees", 
		0,
		180,
		1,
		Tween.TRANS_BACK)
	$Tween.start()
	
	$AxeSFX.play()


func _on_DamageArea_body_entered(_body):
	print("Player hit axe")
	emit_signal("axe_hit")
