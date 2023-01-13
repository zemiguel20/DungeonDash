extends KinematicBody2D

onready var animated_sprite = $AnimatedSprite

# bool flag set up so animation doesn't get cancelled in the next frame
var in_animation = false
var frame_count = 0

# preloading player action sounds
var sound_player_attack = preload("res://assets/sounds/player/sword_attack.mp3")
var sound_player_jump = preload("res://assets/sounds/player/jump.wav")

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
		_play_animation("shoot")
	else:
		if frame_count == 0:
			in_animation = false
		if !in_animation:
			animated_sprite.play("run")
			
	frame_count -= 1

func _physics_process(delta):
	if !$PlayerRunning.is_playing():
		$PlayerRunning.play()
	_set_animation()
