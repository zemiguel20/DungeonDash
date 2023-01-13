extends Node2D

func _on_Trigger_body_entered(_body):
	$Sprite.visible = false
	$ClickSFX.play()


func _on_Trigger_body_exited(_body):
	$Sprite.visible = true
