extends StaticBody2D

@onready var end_platform: Node2D = $EndPlatform
var spawn_node

const PLATFORM_SIZE = 128
var spawnpoint: Vector2
var speed = 60
var has_spawned = false

func _process(delta: float) -> void:
	if spawnpoint == Vector2.ZERO:
		print("'spawnpoint' has not been set.")
		return
	
	position.x -= speed * delta
	
	var ep_position = end_platform.global_position
	# spawns a new platform when the edge of the old platform reaches the edge
	if ep_position.x < spawnpoint.x && has_spawned == false:
		print(ep_position)
		spawn_node.spawn_ground(Vector2(ep_position.x + PLATFORM_SIZE / 2, ep_position.y))
		has_spawned = true
	
	# destroys platform once out of range
	if ep_position.x < -spawnpoint.x:
		queue_free()
