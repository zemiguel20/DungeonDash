extends MovingObstacle

func _ready():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("walk")
	
	var player_node = get_tree().get_root().find_node("Player", true, false)
	player_node.connect("enemy_hit", self, "die")

func activate():
	$EnemySFX.play()
	$AnimatedSprite.play("walk")

func die():
	$EnemyDeathSFX.play()
	$AnimatedSprite.play("dead")
