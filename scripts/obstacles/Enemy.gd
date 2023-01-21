extends MovingObstacle

func _ready():
	$AnimatedSprite.play("idle")

func activate():
	$EnemySFX.play()

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play("dead")
	$EnemyDeathSFX.play()
