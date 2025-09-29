extends Node2D

const GROUND = preload("res://Scenes/ground.tscn")
const SPAWNPOINT: Vector2 = Vector2(800, 0)

func _ready() -> void:
	spawn_ground(Vector2(-SPAWNPOINT.x, SPAWNPOINT.y))

func spawn_ground(pos: Vector2) -> void:
	var ground = GROUND.instantiate()
	ground.spawnpoint = SPAWNPOINT
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	add_child(ground)
