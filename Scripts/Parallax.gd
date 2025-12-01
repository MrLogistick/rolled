extends Node2D

@export var offset: float
@export var obj_name: String
const SIZE = Vector2(480, 450)

var target_scene: PackedScene
var manager
var spawn_node
var cam
var cam_y
var spent_x = false
var spent_y = false

func _ready() -> void:
	var path = "res://Scenes/Background_Scenes/" + obj_name + ".tscn"
	target_scene = load(path)
	if target_scene == null:
		push_error("Failed to load scene: " + path)

func _physics_process(delta: float) -> void:
	cam_y = cam.global_position.y
	global_position -= transform.x * manager.game_speed * offset * delta
	
	if global_position.x < -SIZE.x || global_position.y < cam_y - SIZE.y:
		queue_free()
	
	if global_position.x < 0 && !spent_x:
		spawn_node._spawn_background(Vector2(position.x + SIZE.x, position.y), target_scene, obj_name)
		spent_x = true
	if global_position.y < cam_y && !spent_y:
		spawn_node._spawn_background(Vector2(position.x, position.y + SIZE.y), target_scene, obj_name)
		spent_y = true
