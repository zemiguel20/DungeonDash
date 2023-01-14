extends Node2D

signal spikes_hit

func _on_Trigger_body_entered(body: PhysicsBody2D):
	print("Player entered trigger")
	# Spikes up Tween spikes offset
	$Tween.interpolate_property(
		$Spikes, 
		"offset", 
		Vector2(0,0),
		$DamageArea.position,
		0.2,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT)
	$Tween.start()
	
	$SpikeSFX.play()


func _on_DamageArea_body_entered(body):
	print("Player hit spikes")
	emit_signal("spikes_hit")
