extends PlayerState

class_name RunState

var _anim_sprite: AnimatedSprite


func _init(player, anim_sprite).(player):
	_anim_sprite = anim_sprite


func start():
	_anim_sprite.play("run")


func jump():
	_player.set_state("jump")


func slide():
	_player.set_state("slide")


func attack():
	_player.set_state("attack")


func die():
	_player.set_state("dead")
