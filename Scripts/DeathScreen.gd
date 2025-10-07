extends CanvasLayer

#@onready var MainManager: Node2D = %Manager
@onready var Distance_Tracker: Label = $Distance

var Distance: float = 0
func _ready() -> void:
	pass
	#Distance = MainManager.Distance
	#Distance_Tracker.text = str(Distance)
	
