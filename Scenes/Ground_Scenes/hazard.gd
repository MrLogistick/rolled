extends Area2D

func _on_body_entered(body: Node2D) -> void:
	return
	if body.name == "Player" && is_visible_in_tree():
		body.death()
