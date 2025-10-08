extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var manager: Node2D = %Manager

@export var POSITION = -100
@export var SPEED = 300
@export var JUMP_VELOCITY = -96
@export var GRAVITY = 1200
@export var FALL_GRAVITY = 1500
@export var JUMP_BUFFER = 0.1

var LRMovement = false
var buffer_elapsed: float

func _physics_process(delta: float) -> void:
	move_and_slide()
	position.x = POSITION
	
	if manager.end:
		velocity *= manager.end_multiplier
		sprite.speed_scale *= manager.end_multiplier
		return
	
	if not is_on_floor():
		sprite.speed_scale = 0.5
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY * delta
		else:
			velocity.y += GRAVITY * delta
	else:
		sprite.speed_scale = 1.3
	
	_jump_process(delta)

func _jump_input() -> bool: return Input.is_action_pressed("Jump")

func _jump_process(delta: float):
	# Jump Buffer Stuff
	buffer_elapsed -= 1 * delta;
	if Input.is_action_just_pressed("Jump"):
		buffer_elapsed = JUMP_BUFFER
	if is_on_floor() && buffer_elapsed > 0:
		velocity.y = JUMP_VELOCITY
	
	# Stretch Jump Stuff
	if !_jump_input() && velocity.y < 0:
		velocity.y *= 0.8

func death():
	manager.end = true
