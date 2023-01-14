extends Node2D

func _on_Trigger_body_entered(_body):
	$CutSFX.play()
