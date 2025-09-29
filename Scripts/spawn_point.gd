extends Node2D

const GROUND = preload("res://Scenes/ground.tscn")

func _ready() -> void:
	spawn_ground(Vector2(-global_position.x, global_position.y))

func spawn_ground(pos: Vector2) -> void:
	var ground = GROUND.instantiate()
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	add_child(ground)
	print(global_position)
	ground.spawnpoint = global_position
