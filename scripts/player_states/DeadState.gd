extends PlayerState

class_name DeadState

var _anim_sprite: AnimatedSprite
var _death_sfx: AudioStreamPlayer


func _init(player, anim_sprite, death_sfx).(player):
	_anim_sprite = anim_sprite
	_death_sfx = death_sfx


func start():
	_player.velocity = Vector2() # stop all momentum
	_anim_sprite.play("death")
	_death_sfx.play()


func process():
	# player falls to the ground
	if not _player.is_on_floor():
		_player.velocity.y += _player.gravity
