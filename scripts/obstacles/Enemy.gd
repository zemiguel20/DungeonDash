extends MovingObstacle

func _ready():
	$AnimatedSprite.play("walk")

func activate():
	$EnemySFX.play()

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play("dead")
	$EnemyDeathSFX.play() #TODO: better death SFX
