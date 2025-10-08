extends Node2D

@onready var manager: Node2D = %Manager
@export var SPAWNPOINT: Vector2 = Vector2(300, 0)
var initial_number: int = 5

var ground_list = [
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn")
]

func _ready() -> void:
	spawn_ground(Vector2(-SPAWNPOINT.x, SPAWNPOINT.y), true)
	
func spawn_ground(pos: Vector2, initial: bool) -> void:
	var rand = 0
	if !initial:
		rand = randf_range(0, ground_list.size())
	
	var ground = ground_list[rand].instantiate()
	
	ground.spawnpoint = SPAWNPOINT
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	ground.manager = %Manager
	
	initial_number -= 1
	ground.initial_number = initial_number
	
	add_child(ground)
