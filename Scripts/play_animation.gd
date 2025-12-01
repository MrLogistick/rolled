extends Node2D

var children: Array

func _ready() -> void:
	await get_tree().process_frame
	for child in get_children():
		children.append(child)
		child.frame = 0
		child.play()

func _process(delta: float) -> void:
	for item in children:
		if Engine.time_scale == 1:
			item.speed_scale = 1.0
		else:
			item.speed_scale = 10.0
