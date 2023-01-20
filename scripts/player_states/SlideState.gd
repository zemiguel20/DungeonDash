extends PlayerState

class_name SlideState

var _anim_sprite: AnimatedSprite
var _slide_sfx: AudioStreamPlayer
var _anim_timer: Timer
var _normal_coll: CollisionShape2D
var _slide_coll: CollisionShape2D


func _init(player, anim_sprite, slide_sfx, anim_timer, normal_coll, slide_coll).(player):
	_anim_sprite = anim_sprite
	_slide_sfx = slide_sfx
	_anim_timer = anim_timer
	_normal_coll = normal_coll
	_slide_coll = slide_coll


func start():
	# Switch colliders
	_normal_coll.set_deferred("disabled", true)
	_slide_coll.set_deferred("disabled", false)

	_anim_sprite.play("slide")
	_slide_sfx.play()

	# Animation duration timer start
	var _error = _anim_timer.connect("timeout", self, "end")
	_anim_timer.start()


func end():
	# Switch back colliders
	_normal_coll.set_deferred("disabled", false)
	_slide_coll.set_deferred("disabled", true)
	
	_slide_sfx.stop()
	
	_anim_timer.disconnect("timeout", self, "end")
	
	_player.set_state("run")


func die():
	_player.set_state("dead")
