extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.velocity.y *= 0.5
		body.rising = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.rising = false
