extends Node2D

# Level vars.
export var speed = 300
var total_distance
var inv_total_distance
var distance = 0

var time_elapsed = 0
var potential_locs = []

# Music vars.
const bpm = 135
const time_sig = 4

# Soundcue vars.
var timing
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
	
	var level = GameController.get_level()
	
	# Place obstacles based on which level is loaded
	if (level == 1):
		timing = 4
		place_cue_and_obstacle(0, 4)
		place_cue_and_obstacle(0, 12)
		place_cue_and_obstacle(1, 20)
		place_cue_and_obstacle(2, 28)
		place_cue_and_obstacle(1, 36)
		place_cue_and_obstacle(1, 44)
		place_cue_and_obstacle(0, 52)
		place_cue_and_obstacle(2, 60)
		place_cue_and_obstacle(0, 66)
		place_cue_and_obstacle(0, 72)
		place_cue_and_obstacle(1, 80)
		place_cue_and_obstacle(1, 86)
		place_cue_and_obstacle(2, 92)
		place_cue_and_obstacle(0, 100)
		place_cue_and_obstacle(1, 106)
		place_cue_and_obstacle(1, 112)
		place_cue_and_obstacle(2, 120)
		place_cue_and_obstacle(2, 128)
		
	elif (level == 2):
		timing = 2
		place_cue_and_obstacle(0, 4)
		place_cue_and_obstacle(1, 12)
		place_cue_and_obstacle(0, 20)
		place_cue_and_obstacle(2, 28)
		place_cue_and_obstacle(0, 34)
		place_cue_and_obstacle(0, 38)
		place_cue_and_obstacle(1, 44)
		place_cue_and_obstacle(2, 48)
		place_cue_and_obstacle(1, 54)
		place_cue_and_obstacle(2, 60)
		place_cue_and_obstacle(1, 66)
		place_cue_and_obstacle(1, 70)
		place_cue_and_obstacle(0, 74)
		place_cue_and_obstacle(2, 78)
		place_cue_and_obstacle(0, 82)
		place_cue_and_obstacle(0, 86)
		place_cue_and_obstacle(1, 90)
		place_cue_and_obstacle(2, 94)
		place_cue_and_obstacle(0, 100)
		place_cue_and_obstacle(1, 104)
		place_cue_and_obstacle(2, 110)
		place_cue_and_obstacle(1, 116)
		place_cue_and_obstacle(0, 120)
		place_cue_and_obstacle(0, 124)
		place_cue_and_obstacle(0, 128)
		
	elif (level == 3):
		timing = 1
		place_cue_and_obstacle(0, 5)
		place_cue_and_obstacle(2, 13)
		place_cue_and_obstacle(1, 21)
		place_cue_and_obstacle(2, 29)
		place_cue_and_obstacle(1, 35)
		place_cue_and_obstacle(0, 43)
		place_cue_and_obstacle(0, 47)
		place_cue_and_obstacle(2, 55)
		place_cue_and_obstacle(2, 59)
		place_cue_and_obstacle(0, 67)
		place_cue_and_obstacle(0, 71)
		place_cue_and_obstacle(1, 75)
		place_cue_and_obstacle(1, 79)
		place_cue_and_obstacle(2, 83)
		place_cue_and_obstacle(2, 87)
		place_cue_and_obstacle(0, 95)
		place_cue_and_obstacle(1, 103)
		place_cue_and_obstacle(0, 107)
		place_cue_and_obstacle(2, 115)
		place_cue_and_obstacle(2, 119)
		place_cue_and_obstacle(1, 123)
		place_cue_and_obstacle(0, 127)
		place_cue_and_obstacle(1, 131)
	
	$Song.play()


func _process(_delta):
	# Compensate for audio playing delays.
	var time = $Song.get_playback_position() + AudioServer.get_time_since_last_mix()
	time -= AudioServer.get_output_latency() + offset
	
	# Calculate the travelled distance.
	distance = time * speed
	
	# Play the correct sound if the player has reached a soundcue location.
	if ctr < len(soundcue_locs) && !obs_soon && distance > soundcue_locs[ctr]:
		match (soundcue_types[ctr]):
			0:
				$SoundCueClick.play()
			1:
				$SoundCueCut.play()
			2:
				$SoundCueGrunt.play()
		
		# An obstacle is coming up.
		obs_soon = true
	
	elif ctr < len(obstacle_locs) && obs_soon && distance > obstacle_locs[ctr]:
		# Play animation.
		obstacles[ctr].activate()
		
		# Lookout for the next soundcue location.
		obs_soon = false
		ctr += 1
	
	# TODO: reset values if the player dies


# Place a soundcue and an obstacle with a given type at a given beat in the song.
func place_cue_and_obstacle(type, beat):	
	soundcue_types.append(type)
	
	# Add small offset to location and soundcue list if obstacle is a saw: triggers animation later,
	# which provides more leniency
	if (type == 1):
		soundcue_locs.append(potential_locs[beat] + 10)
		obstacle_locs.append(potential_locs[beat + timing] + 50)
	else:
		soundcue_locs.append(potential_locs[beat])
		obstacle_locs.append(potential_locs[beat + timing])
	
	var pos = potential_locs[beat + timing]
	var node: MovingObstacle
	
	# Add the desired obstacle to the scene.
	match (type):
		0:
			node = spikes.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos + 130, 60)
		1:
			node = axe.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos + 50, 10)
		2:
			node = enemy.instance()
			add_child(node)
			node.set_owner(scene)
			node.position += Vector2(pos + 100, 60)
	
	# Move the new obstacle to the left and append it to the list.
	node.constant_linear_velocity.x = -speed
	obstacles.append(node)
