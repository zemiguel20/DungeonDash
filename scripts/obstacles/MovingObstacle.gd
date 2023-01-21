# Base class for moving obstacles.
# Concrete obstacle classes should define activate

extends Area2D

class_name MovingObstacle

export var constant_linear_velocity: Vector2 = Vector2.ZERO


func activate():
	pass


func _physics_process(delta):
	position += constant_linear_velocity * delta


func _on_body_entered(body):
	if body.has_method("die"):
		body.die()
