extends Node2D

const GROUND = preload("res://Scenes/ground.tscn")
var spawn_rate = 1.0

func _ready() -> void:
	var initial_ground = GROUND.instantiate()
	initial_ground.position = Vector2(0, 65)
