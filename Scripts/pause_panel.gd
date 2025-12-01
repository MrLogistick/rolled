extends CanvasLayer

@onready var manager: Node2D = %Manager

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Pause"):
		if visible:
			manager.paused = false
			Engine.time_scale = 1.0
			visible = false
			return
		else:
			manager.paused = true
			Engine.time_scale = 0.0
			visible = true
			return
