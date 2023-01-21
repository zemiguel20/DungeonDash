extends KinematicBody2D


signal player_died

export var gravity = 10
export var jump_speed = 300
var velocity = Vector2()

var _current_state: PlayerState

var timer_hitbox = Timer.new()
var timer_cd = Timer.new()
var cooldown = false

func _ready():
	set_state("run")
	initialize_timers()

func _physics_process(_delta):
	if Input.is_action_pressed("player_jump") and !cooldown:
		_current_state.jump()
		start_cooldown()
	elif Input.is_action_pressed("player_slide") and !cooldown:
		_current_state.slide()
		start_cooldown()
	elif Input.is_action_pressed("player_shoot") and !cooldown:
		_current_state.attack()
		start_cooldown()
		timer_hitbox.start()
	
	var _final_velocity = move_and_slide(velocity, Vector2.UP)
	
	_current_state.process()


func _on_attack_hit(body):
	print("hit something")
	if body.has_method("die"):
		body.die()


func die():
	_current_state.die()
	emit_signal("player_died")


func set_state(state: String):
	match state:
		"run":
			_current_state = RunState.new(self, $AnimatedSprite)
		"jump":
			_current_state = JumpState.new(self, $AnimatedSprite, $JumpSFX)
		"slide": 
			_current_state = SlideState.new(self, $AnimatedSprite, $SlideSFX, 
											$SlideDuration, $NormalCollisionShape, 
											$SlideCollisionShape)
		"attack":
			_current_state = AttackState.new(self, $AnimatedSprite, $AttackSFX,
											$AttackHitbox/Hitbox)
		"dead":
			_current_state = DeadState.new(self, $AnimatedSprite, $DeathSFX)
		_:
			print("Unknown state. Default to run.")
			_current_state = RunState.new(self, $AnimatedSprite)
		
	_current_state.start()

func initialize_timers():
	add_child(timer_cd)
	timer_cd.connect("timeout", self, "stop_cooldown")
	timer_cd.one_shot = true
	timer_cd.wait_time = 1.5
	
	add_child(timer_hitbox)
	timer_hitbox.connect("timeout", self, "disable_hitbox")
	timer_hitbox.one_shot = true
	timer_hitbox.wait_time = 0.25

func start_cooldown():
	cooldown = true
	timer_cd.start()
	
func stop_cooldown():
	cooldown = false
	
func disable_hitbox():
	$AttackHitbox/Hitbox.set_deferred("disabled", true)
