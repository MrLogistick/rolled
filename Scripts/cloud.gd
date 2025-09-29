extends Panel

@export var MovementSpeed = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 576
	position.y = randi_range(-324, 324)
	scale.x = randi_range(1.0, 2.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += -MovementSpeed * delta
