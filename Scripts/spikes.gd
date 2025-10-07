extends Area2D

var speed = 640

func _process(delta: float) -> void:
	position += -transform.x.normalized() * speed * delta
