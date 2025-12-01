extends CanvasLayer

@onready var manager = get_parent()
@onready var text: Label = $YouDiedText

var Distance: float = 0
func _process(_delta: float) -> void:
	if manager.elevation <= 0.0:
		text.text = "You Win!"
	else:
		text.text = "You Died!"
	
	if Input.is_physical_key_pressed(KEY_R):
		manager.retry = true
	
func _on_retry_button_pressed() -> void:
	manager.retry = true

func _on_tutorial_button_pressed() -> void:
	Global.tutorial = true
	manager.retry = true
