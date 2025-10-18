extends TileMapLayer

@onready var manager: Node2D = %Manager

const VISIBLE_DIST = 10
const END_POSITION = -300
const END_ALPHA = 0.58
const START_POSITION = 200
const START_ALPHA = 1.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if manager.elevation <= VISIBLE_DIST:
		visible = true
	
	
