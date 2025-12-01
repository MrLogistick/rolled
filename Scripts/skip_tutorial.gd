extends AnimatedSprite2D

func _ready() -> void:
	await get_tree().process_frame
	
	play()
	await get_tree().create_timer(8.0).timeout
	visible = false

func _process(delta: float) -> void:
	if !Global.tutorial:
		visible = false
		return
	
	if Engine.time_scale == 1:
		speed_scale = 1.0
	else:
		speed_scale = 10.0
	
	if !is_in_group("Skip"): return
	
	if Input.is_physical_key_pressed(KEY_R) && Global.tutorial:
		Engine.time_scale = 1.0
		Global.tutorial = false
		visible = false
