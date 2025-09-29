extends Node2D

const GROUND = preload("res://Scenes/ground.tscn")

func _ready() -> void:
	spawn_ground(Vector2(-800, 250))

func spawn_ground(pos: Vector2) -> void:
	var ground = GROUND.instantiate()
	ground.spawnpoint = Vector2(800, 250)
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	add_child(ground)
