extends CanvasLayer

@onready var Manager = get_parent()
#@onready var Distance_Tracker: Label = $Distance

var Distance: float = 0
func _process(_delta: float) -> void:
	if Input.is_physical_key_pressed(KEY_R):
		Manager.retry = true
	
	#Distance = MainManager.Distance
	#Distance_Tracker.text = str(Distance)
	
func _on_retry_button_pressed() -> void:
	Manager.retry = true
