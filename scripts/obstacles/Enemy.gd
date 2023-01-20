extends MovingObstacle

func _ready():
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play("walk")
	
	var player_node = get_tree().get_root().find_node("Player", true, false)
	player_node.connect("enemy_hit", self, "die")

func activate():
	pass

func die():
	$CollisionShape2D.set_deferred("disabled", true)
	$AnimatedSprite.play("dead")
	
	$EnemyDeathSFX.play()
	
	var timer = get_node("Timer")
	timer.set_wait_time(1)
	timer.start()
	
func _on_Timer_timeout():
	$CollisionShape2D.set_deferred("disabled", false)
	$AnimatedSprite.play("walk")
