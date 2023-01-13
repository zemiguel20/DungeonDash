extends KinematicBody2D

# Export the speed, used in the obstacle placer
export var for_speed = 300

const gravity = 1000
const jump_impulse = 400
var velocity = Vector2()

var starting_pos = Vector2()	

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_pos = global_position


func _process(delta):
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_just_pressed("player_jump"):
			velocity.y -= jump_impulse
			$JumpAudio.play()
	else:
		velocity.y += gravity * delta
		
	velocity.x = for_speed
		
# warning-ignore:return_value_discarded
	move_and_slide(velocity, Vector2.UP)
	
	# Check for collisions
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		
		# If the player collided with a spike, kill them
		if collision.collider.name == "Spikes":
			die()
			break


func die():
	# TODO: play some kind of death animation 
	
	# Play the death sound.
	$DieAudio.play()
	# Reset the player to its starting pos.
	set_global_position(starting_pos)
