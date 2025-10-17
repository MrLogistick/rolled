extends CanvasLayer

@onready var Manager = get_parent()
#@onready var Distance_Tracker: Label = $Distance

var Distance: float = 0
func _ready() -> void:
	pass
	#Distance = MainManager.Distance
	#Distance_Tracker.text = str(Distance)
	
func _on_retry_button_pressed() -> void:
	Manager.retry = true
