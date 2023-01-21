extends PlayerState

class_name JumpState

var _anim_sprite: AnimatedSprite
var _jump_sfx: AudioStreamPlayer


func _init(player, anim_sprite, jump_sfx).(player):
	_anim_sprite = anim_sprite
	_jump_sfx = jump_sfx

	
func start():
	_anim_sprite.play("jump")
	_jump_sfx.play()
	_player.velocity.y = -_player.jump_speed #add jump impulse


func process():
	# Apply gravity while midair
	if _player.is_on_floor():
		_player.set_state("run")
	else:
		_player.velocity.y += _player.gravity


func die():
	_player.set_state("dead")
