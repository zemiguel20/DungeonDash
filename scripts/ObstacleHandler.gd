extends Node2D

# Level vars.
export var speed = 300
var total_distance
var inv_total_distance
var distance = 0

var time_elapsed = 0
var potential_locs = []

# Music vars.
const bpm = 130
const time_sig = 4

# Soundcue vars.
const timing = 2
var soundcue_locs = []
var soundcue_types = [] # 0 = click, 1 = cut, 2 = grunt
var ctr = 0

# List of obstacle locations and the obstacles themselves
var obstacle_locs = []
var obstacles = []

# Indicates that an obstacle is coming up after a sound cue.
var obs_soon = false

# Scene and various obstacles that can be placed.
var scene
var spikes
var axe
var enemy

# Offset, used to match the sfx with the beat of the song.
const offset = 0.17

# Called when the node enters the scene tree for the first time.
func _ready():	
	# Get the current scene,
	scene = get_tree().get_current_scene()
	
	# Load the three types of obstacles. TODO: fix paths
	spikes = load("res://assets/spikes/Spikes.tscn")
	axe = load("res://assets/axe/Axe.tscn")
	enemy = load("res://assets/enemy/Enemy.tscn")
	
	# Initialize speed dependent variables.
	total_distance = speed * 60
	inv_total_distance = float(total_distance) / bpm
	
	# Calculate all x coords that line up with a given bpm.
	for i in range(bpm + 1):
		potential_locs.append(i * inv_total_distance)
	
	var type = 0
	
	# Choose some spots for sound cues. TODO: these are just for testing
	for j in range(2, 120, 4):
		if j + timing < len(potential_locs):
			soundcue_locs.append(potential_locs[j])
			soundcue_types.append(type)
			obstacle_locs.append(potential_locs[j + timing])
			
			place_obstacle(type, potential_locs[j + timing])
			
			if type == 0:
				type = 1
			elif type == 1:
				type = 2
			else:
				type = 0
	
	$Song.play()


func _process(delta):
	# Compensate for audio playing delays.
	var time = $Song.get_playback_position() + AudioServer.get_time_since_last_mix()
	time -= AudioServer.get_output_latency() + offset
	
	# Calculate the travelled distance.
	distance = time * speed
	
	# Play the correct sound if the player has reached a soundcue location.
	if !obs_soon && distance > soundcue_locs[ctr] && ctr < len(soundcue_locs) - 1:
		match (soundcue_types[ctr]):
			0:
				$SoundCueClick.play()
			1:
				$SoundCueCut.play()
			2:
				$SoundCueGrunt.play()
		
		# An obstacle is coming up.
		obs_soon = true
	
	elif obs_soon && distance > obstacle_locs[ctr] &&  ctr < len(obstacle_locs) - 1:
		# Play animation.
		obstacles[ctr].activate()
		
		# Lookout for the next soundcue location.
		obs_soon = false
		ctr += 1
	
	# TODO: reset values if the player dies


# Place an obstacle with a given type at a given position.
func place_obstacle(type, pos):
	var node: MovingObstacle
	
	# TODO: change the positions to the final ground and place activation boxes
	# (or something similar)
	match (type):
		0:
			node = spikes.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos + 125, 60)
		1:
			node = axe.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos + 5, 10)
		2:
			node = enemy.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos, 60)
			
	node.constant_linear_velocity.x = -speed
	obstacles.append(node)
