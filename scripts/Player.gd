extends KinematicBody2D

enum State {
	RUN,
	JUMP,
	SLIDE,
	ATTACK,
	DEAD
}

# Start state Jump as he might spawn slightly airborne
var current_state = State.JUMP

# Export the speed, used in the obstacle placer
export var for_speed = 300
export var gravity = 1000
export var jump_speed = 400
var velocity = Vector2()

func _ready():
	velocity.x = for_speed

func _physics_process(delta):
	match current_state:
		State.RUN:
			# Check player action
			if Input.is_action_pressed("player_jump"):
				_set_state(State.JUMP)
			elif Input.is_action_pressed("player_slide"):
				_set_state(State.SLIDE)
			elif Input.is_action_pressed("player_shoot"):
				_set_state(State.ATTACK)
			_move()
		State.JUMP:
			# Apply gravity while midair
			if is_on_floor():
				_set_state(State.RUN)
			else:
				velocity.y += gravity * delta
			_move()
		State.SLIDE:
			# keep sliding while action is pressed
			if not Input.is_action_pressed("player_slide"):
				_set_state(State.RUN)
			_move()
		State.ATTACK:
			_move()
		State.DEAD:
			# move player to the floor using gravity if dead midair
			if not is_on_floor():
				velocity.y += gravity * delta
				_move()

func _move():
	var _final_velocity = move_and_slide(velocity, Vector2.UP)

func _set_state(new_state):
	# state cleanup
	_exit_current_state()
	
	match new_state:
		State.RUN:
			velocity.y = 0
			$AnimatedSprite.play("run")
		State.JUMP:
			velocity.y -= jump_speed #add jump impulse
			$AnimatedSprite.play("jump")
			$JumpSFX.play()
		State.SLIDE:
			# switch colliders
			$SlideCollisionShape.disabled = false
			$NormalCollisionShape.disabled = true
			
			$AnimatedSprite.play("slide")
			$SlideSFX.play()
		State.ATTACK:
			# lock animation until end, then end state
			var _error = $AnimatedSprite.connect("animation_finished", self, "_on_attack_anim_finished")
			$AnimatedSprite.play("attack")
			$AttackSFX.play()
			$AttackHitbox/Hitbox.disabled = false
		State.DEAD:
			velocity = Vector2() # stop movement
			$AnimatedSprite.play("death")
			$DeathSFX.play()

	current_state = new_state

func _exit_current_state():
	match current_state:
		State.RUN:
			pass
		State.JUMP:
			pass
		State.SLIDE:
			# switch back colliders
			$SlideCollisionShape.disabled = true
			$NormalCollisionShape.disabled = false
			
			$SlideSFX.stop()
		State.ATTACK:
			$AnimatedSprite.disconnect("animation_finished", self, "_on_attack_anim_finished")
			$AttackHitbox/Hitbox.set_deferred("disabled", true)
		State.DEAD:
			pass

func _on_attack_anim_finished():
	_set_state(State.RUN)

func _die():
	_set_state(State.DEAD)


func _on_AttackHitbox_body_entered(body):
	print("hit")
	if body.has_method("take_damage"):
		body.take_damage()
