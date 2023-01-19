# Base class for moving obstacles.
# Concrete obstacle classes should define activate

extends KinematicBody2D

class_name MovingObstacle

export var constant_linear_velocity: Vector2 = Vector2.ZERO

func activate():
	pass

func _physics_process(delta):
# warning-ignore:return_value_discarded
	move_and_collide(constant_linear_velocity * delta)
