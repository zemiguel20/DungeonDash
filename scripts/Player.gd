extends KinematicBody2D

signal player_collided(other_body)
signal player_died

export var gravity = 10
export var jump_speed = 300
var velocity = Vector2()

var _current_state: PlayerState


func _ready():
	set_state("run")


func _physics_process(_delta):
	if Input.is_action_pressed("player_jump"):
		_current_state.jump()
	elif Input.is_action_pressed("player_slide"):
		_current_state.slide()
	elif Input.is_action_pressed("player_shoot"):
		_current_state.attack()
	
	var _final_velocity = move_and_slide(velocity, Vector2.UP)
	
	_current_state.process()


func _on_attack_hit(body):
	print("hit something")
	if body.has_method("die"):
		body.die()


func die():
	set_state("dead")
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
		_:
			print("Unknown state. Default to run.")
			_current_state = RunState.new(self, $AnimatedSprite)
		
	_current_state.start()
