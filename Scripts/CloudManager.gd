extends Node2D

const CLOUD = preload("uid://d3m0abmudfqt")

func _ready() -> void:
	spawn_clouds()

func spawn_clouds() -> void:
	var cloud = CLOUD.instantiate()
	add_child(cloud)
	
	var random_value = randf_range(0.1, 0.5) # float instead of int
	await get_tree().create_timer(random_value).timeout
	spawn_clouds()
