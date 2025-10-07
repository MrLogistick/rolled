extends Node2D

const SPAWNPOINT: Vector2 = Vector2(800, 0)

var stop = false

var ground_list = [
	preload("res://Scenes/Ground_Scenes/default_ground.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn")
]

func _ready() -> void:
	spawn_ground(Vector2(-SPAWNPOINT.x, SPAWNPOINT.y))
	
func spawn_ground(pos: Vector2) -> void:
	if stop == true: return
	
	var rand = randf_range(0, ground_list.size())
	var ground = ground_list[rand].instantiate()
	ground.spawnpoint = SPAWNPOINT
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	add_child(ground)
	
func Death():
	stop = true
