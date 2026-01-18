extends Area2D

var speed : float = 280.0

func _process(delta):
	delta = min(delta, 0.05)
	#position.x -= speed * delta
	position.y = max(position.y, 0)
	
	# Clean up when off-screen
	if position.x < -100:
		call_deferred("queue_free")

func _on_body_entered(body):
	if body.is_in_group("player"):
		body.die()
