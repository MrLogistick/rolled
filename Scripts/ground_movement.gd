extends StaticBody2D

@onready var end_platform: Node2D = $FloorSprite/EndPlatform
var spawn_node
# @onready var Player: CharacterBody2D = %Player

var Stop = false

# Steep: 71.5 Shallow 65.5
const PLATFORM_SIZE: float = 65.5
var spawnpoint: Vector2
var speed: float
var has_spawned = false

func _process(delta: float) -> void:
	if spawnpoint == Vector2.ZERO:
		print("'spawnpoint' has not been set.")
		return
	
	global_position += -transform.x * speed * delta
	
	var ep_position = end_platform.global_position
	# spawns a new platform when the edge of the old platform reaches the edge
	if ep_position.x < spawnpoint.x && has_spawned == false:
		# spawn_node.spawn_ground(Vector2(ep_position.x + PLATFORM_SIZE / 2, ep_position.y))
		spawn_node.spawn_ground(Vector2(ep_position + transform.x * PLATFORM_SIZE / 2))
		has_spawned = true
	
	# destroys platform once out of range
	if ep_position.x < -spawnpoint.x:
		queue_free()
		

#func On_Spike_Trap_Area_Entered(body: Node2D) -> void:
#	if body.is_in_group("Player"):
#		spawn_node.Death()
