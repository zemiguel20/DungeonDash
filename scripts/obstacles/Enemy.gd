extends KinematicBody2D #TODO: change to MovingObstacle

export var constant_linear_velocity: Vector2 = Vector2.ZERO

func _ready():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("idle")

func activate():
	$EnemySFX.play()

func _physics_process(delta):
	move_and_collide(constant_linear_velocity * delta)
