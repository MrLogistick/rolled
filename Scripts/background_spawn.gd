extends Node2D

var scenes = [
	preload("res://Scenes/Background_Scenes/bg_back_2.tscn"),
	preload("res://Scenes/Background_Scenes/bg_back.tscn"),
	preload("res://Scenes/Background_Scenes/bg_mid.tscn"),
	preload("res://Scenes/Background_Scenes/bg_front.tscn")
]

func _ready() -> void:
	for scene in scenes:
		_spawn_background(Vector2.ZERO, scene, "")

func _process(delta: float) -> void:
	pass

func _spawn_background(pos: Vector2, target: PackedScene, name: String):
	for child in get_children():
		if child.global_position.distance_to(pos) < 10.0 && child.obj_name == name:
			return
	
	var instance = target.instantiate()
	
	instance.spawn_node = get_node("/root/HamishScene/BackgroundManager")
	instance.manager = %Manager
	instance.cam = get_node("/root/HamishScene/Camera2D")
	instance.global_position = pos
	
	add_child(instance)
