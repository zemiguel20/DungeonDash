extends PlayerState

class_name DeadState

var _anim_sprite: AnimatedSprite
var _death_sfx: AudioStreamPlayer


func start():
	_player.velocity = Vector2() # stop all momentum
	_player.set_collision_mask_bit(1, false) # disable collision with obstacles
	_anim_sprite.play("death")
	_death_sfx.play()


func process():
	# player falls to the ground
	if not _player.is_on_floor():
		_player.velocity.y += _player.gravity
