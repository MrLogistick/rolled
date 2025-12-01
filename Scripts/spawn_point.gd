extends Node2D

@onready var manager: Node2D = %Manager
@onready var player: CharacterBody2D = %Player
@export var SPAWNPOINT: Vector2 = Vector2(300, 0)
var initial_number: int = 5
var tutorial_bubbles: bool = false
var spawning = true

var ground_list = [
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_default.tscn"),
	
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_hazard.tscn"),
	
	preload("res://Scenes/Ground_Scenes/floor_drop.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_drop.tscn"),
	preload("res://Scenes/Ground_Scenes/floor_drop.tscn"),
	
	preload("res://Scenes/Ground_Scenes/floor_cliff.tscn"),
	
	preload("res://Scenes/Ground_Scenes/floor_bubbles.tscn"),
	
	preload("res://Scenes/Ground_Scenes/floor_end.tscn")
]

func _ready() -> void:
	spawn_ground(Vector2(-SPAWNPOINT.x, SPAWNPOINT.y), true)
	
func spawn_ground(pos: Vector2, initial: bool) -> void:
	if !spawning: return
	
	var rand = 0
	# General Spawner
	if !initial:
		rand = randf_range(0, ground_list.size() - 1)
	# Bubbles Tutorial
	if manager.pregame && player.health <= player.INITIAL_HEALTH * 0.75 && !tutorial_bubbles:
		rand = ground_list.size() - 2
		tutorial_bubbles = true
	# End Game
	if manager.elevation <= 15.0:
		rand = ground_list.size() - 1
		spawning = false
	
	var ground = ground_list[rand].instantiate()
	
	ground.spawnpoint = SPAWNPOINT
	ground.global_position = pos
	ground.spawn_node = %SpawnPoint
	ground.manager = %Manager
	
	if !manager.pregame: initial_number -= 1
	ground.initial_number = initial_number
	
	add_child(ground)
