extends Node2D

const SPAWNPOINT: Vector2 = Vector2(800, 0)

var ground_list = [
	preload("res://Scenes/ground.tscn"),
	# preload("res://Scenes/ground_ramp.tscn")
]

func _ready() -> void:
	spawn_ground(Vector2(-SPAWNPOINT.x, SPAWNPOINT.y))

func spawn_ground(pos: Vector2) -> void:
	var rand = randf_range(0, ground_list.size())
	var ground = ground_list[rand].instantiate()
	ground.spawnpoint = SPAWNPOINT
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	add_child(ground)
