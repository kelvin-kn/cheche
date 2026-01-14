extends Area2D

var speed : float = 280.0

func _process(delta):
	delta = min(delta, 0.05)
	position.x -= speed * delta

	# Clean up when off-screen
	if position.x < -100:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		body.die()
