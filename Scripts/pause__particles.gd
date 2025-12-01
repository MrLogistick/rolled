extends GPUParticles2D

var manager

func _ready() -> void:
	manager = get_parent().get_parent().get_parent().manager

func _process(delta: float) -> void:
	if manager.end:
		speed_scale *= manager.end_multiplier
	else:
		speed_scale = 1.0
