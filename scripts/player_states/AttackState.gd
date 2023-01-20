extends PlayerState

class_name AttackState

var _anim_sprite: AnimatedSprite
var _attack_sfx: AudioStreamPlayer
var _attack_hitbox: CollisionShape2D


func _init(player, anim_sprite, attack_sfx, attack_hitbox).(player):
	_anim_sprite = anim_sprite
	_attack_sfx = attack_sfx
	_attack_hitbox = attack_hitbox
	

func start():
	# lock animation until end, then end state
	var _error = _anim_sprite.connect("animation_finished", self, "end")
	_anim_sprite.play("attack")
	_attack_sfx.play()
	_attack_hitbox.set_deferred("disabled", false)
	
	
func end():
	_anim_sprite.disconnect("animation_finished", self, "end")
	_attack_hitbox.set_deferred("disabled", true)
	_player.set_state("run")


func die():
	_player.set_state("dead")
