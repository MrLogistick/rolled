extends StaticBody2D

@onready var start_platform: Node2D = $StartPlatform
@onready var end_platform: Node2D = $EndPlatform

const SPAWNPOINT = 150


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	position.x -= 60 * delta
	
