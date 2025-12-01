extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && is_visible_in_tree():
		if body.air <= 0:
			body.velocity.y = -250
		body.air += 12
