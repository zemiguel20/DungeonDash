extends Node2D

# Level vars
var player
var speed
var total_distance
var inv_total_distance
var distance = 0

var time_elapsed = 0
var potential_locs = []

# Music vars
const bpm = 130
const time_sig = 4

# Soundcue vars
const timing = 2
var soundcue_locs = []
var soundcue_types = [] # 0 = click, 1 = cut, 2 = grunt
var next_loc
var ctr = 0

# List of obstacle locations
var obstacle_locs = []

# Scene and various obstacles that can be placed.
var scene
var spikes
var axe
var enemy

# Time related vars
var time_begin
var time_delay

# Called when the node enters the scene tree for the first time.
func _ready():	
	# Get the current scene,
	scene = get_tree().get_current_scene()
	
	# Load the three types of obstacles. TODO: fix paths
	spikes = load("res://assets/objects/Spikes.tscn")
	axe = load("res://assets/objects/Spikes.tscn")
	enemy = load("res://assets/objects/Spikes.tscn")
	
	# Initialize player-dependent variables.
	player = get_node("/root/Node2D/Guy")
	speed =  player.for_speed
	total_distance = speed * 60
	inv_total_distance = float(total_distance) / bpm
	
	# Calculate all x coords that line up with a given bpm.
	for i in range(bpm + 1):
		potential_locs.append(i * inv_total_distance)
	
	# Choose some spots for sound cues.
	for j in range(2, 120, 4):
		if j + timing < len(potential_locs):
			soundcue_locs.append(potential_locs[j])
			soundcue_types.append(0)
			obstacle_locs.append(potential_locs[j + timing])
			
			place_obstacle(0, potential_locs[j + timing])
	
	# Set next_loc to the first soundcue location
	next_loc = soundcue_locs[0]
	
	# Calculate time begin and delays, needed to compensate for audio playing delays.
	time_begin = OS.get_ticks_usec()
	time_delay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency()
	$Song.play()


func _process(delta):
	# Compensate for audio playing delays.
	var time = (OS.get_ticks_usec() - time_begin) / 1000000.0
	time -= time_delay + 0.1
	time = max(0, time)
	
	# Calculate the travelled distance.
	distance = time * speed
	
	# Play the correct sound if the player has reached a soundcue location.
	if distance > next_loc && ctr < len(soundcue_locs) - 1:
		match (soundcue_types[ctr]):
			0:
				$SoundCueClick.play()
			1:
				$SoundCueCut.play()
			2:
				$SoundCueGrunt.play()

		# Lookout for the next soundcue location
		ctr += 1
		next_loc = soundcue_locs[ctr]


# Place an obstacle with a given type at a given position.
func place_obstacle(type, pos):
	var node
	
	# TODO: change the positions to the final ground and place activation boxes
	# (or something similar)
	match (type):
		0:
			node = spikes.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos, 60)
		1:
			node = axe.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos, 60)
		2:
			node = enemy.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos, 60)
			
			# TODO: have it move (if some internal script doesn't handle that)
	
	
	
	
