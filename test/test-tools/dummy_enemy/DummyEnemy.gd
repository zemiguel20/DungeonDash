extends KinematicBody2D

signal enemy_hit

func take_damage():
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)

func _on_DamageArea_body_entered(_body):
	emit_signal("enemy_hit")
