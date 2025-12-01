extends TileMapLayer

@onready var manager: Node2D = %Manager
@onready var cam: Camera2D = %Camera2D

const VISIBLE_DIST = 10
const END_POSITION = -300
const END_ALPHA = 0.58
const START_POSITION = 200
const START_ALPHA = 1.0

var new_start_pos: float
var segment_size: float

func _ready() -> void:
	segment_size = START_POSITION / VISIBLE_DIST # 20

func _process(delta: float) -> void:
	if manager.elevation <= VISIBLE_DIST:
		if !visible:
			visible = true
			new_start_pos = cam.position.y
		
		position.y = segment_size * manager.elevation + cam.position.y
