extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" && is_visible_in_tree():
		if body.air > 48:
			body.air -= 48
			body.velocity.y = -250
		elif body.air > 0:
			body.air = 0
			body.velocity.y = -250
		else:
			body.health -= body.INITIAL_HEALTH / 7
			body.manager.game_speed -= 20
