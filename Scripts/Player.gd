extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite2D

const POSITION = -250
const SPEED = 300
const JUMP_VELOCITY = -650
const GRAVITY = 1200
const FALL_GRAVITY = 1500
const jump_buffer = 0.1

var LRMovement = false
var buffer_elapsed: float

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		sprite.speed_scale = 0.5
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY * delta
		else:
			velocity.y += GRAVITY * delta
	else:
		sprite.speed_scale = 1.3
	
	buffer_elapsed -= 1 * delta;
	if Input.is_action_just_pressed("Jump"):
		buffer_elapsed = jump_buffer
	
	if buffer_elapsed > 0 && is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if LRMovement == true:
		var direction := Input.get_axis("Left", "Right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	position.x = POSITION
	move_and_slide()
