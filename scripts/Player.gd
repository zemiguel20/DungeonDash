extends KinematicBody2D

# Export the speed, used in the obstacle placer
export var for_speed = 300

const gravity = 1000
const jump_impulse = 400
var velocity = Vector2()

var starting_pos = Vector2()	

onready var animated_sprite = $AnimatedSprite

# bool flag set up so animation doesn't get cancelled in the next frame
var in_animation = false
var frame_count = 0

var timer = Timer.new()
var player_dead = false

# preloading player action sounds
var sound_player_attack = preload("res://assets/sounds/player/sword_attack.mp3")
var sound_player_jump = preload("res://assets/sounds/player/jump.wav")

# Called when the node enters the scene tree for the first time.
func _ready():
	starting_pos = global_position

func _process(delta):
	_set_animation()
	
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
	# set speed to 0 to stop colliding with the obstacle	
	for_speed = 0
	player_dead = true
	_play_animation("death")
	
	# Play the death sound.
	$DieAudio.play()
	
	add_child(timer)
	timer.wait_time = 3 # sets how long player stays dead on ground before respawn
	timer.connect("timeout", self ,"respawn")
	timer.start()

func respawn():
	set_global_position(starting_pos)
	player_dead = false
	for_speed = 300
	timer.stop()

# function that sets a flag and fetches the correct animation
func _play_animation(animation):
	in_animation = true
	animated_sprite.play(animation)
	$PlayerAction.play()

# function that reads user input and sets an animation
func _set_animation():
	if in_animation and frame_count < 0:
		frame_count = 30 # how long an animation is being played
	
	if Input.is_action_pressed("player_jump") and !in_animation:
		$PlayerAction.stream = sound_player_jump
		_play_animation("jump")
	elif Input.is_action_pressed("player_slide") and !in_animation:
		_play_animation("slide")
	elif Input.is_action_pressed("player_shoot") and !in_animation:
		$PlayerAction.stream = sound_player_attack
		_play_animation("attack")
	else:
		if frame_count == 0:
			in_animation = false
		if frame_count == 0 and player_dead:
			animated_sprite.play("dead")
		if !in_animation and !player_dead:
			animated_sprite.play("run")
			
	frame_count -= 1
