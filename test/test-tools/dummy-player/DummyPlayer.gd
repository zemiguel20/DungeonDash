extends KinematicBody2D

export var speed = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if Input.is_physical_key_pressed(KEY_W):
		move_and_collide(Vector2(0, -speed*delta))
	if Input.is_physical_key_pressed(KEY_S):
		move_and_collide(Vector2(0, speed*delta))
	if Input.is_physical_key_pressed(KEY_A):
		move_and_collide(Vector2(-speed*delta, 0))
	if Input.is_physical_key_pressed(KEY_D):
		move_and_collide(Vector2(speed*delta, 0))
