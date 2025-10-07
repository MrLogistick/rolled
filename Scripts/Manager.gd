extends Node2D

@onready var distance_tracker: Timer = $"../DistanceTracker"
@onready var distance_text: Label = $"../CanvasLayer/DistanceText"

var Distance: float = 0


func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	Distance += 0.1
	distance_text.text = "Distance: " + str(round(Distance))
