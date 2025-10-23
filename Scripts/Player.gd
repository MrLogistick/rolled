extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var manager: Node2D = %Manager

const DEATH_SCREEN = preload("res://Scenes/death_screen.tscn")

var POSITION = -50
var JUMP_VELOCITY = -175
var GRAVITY = 400
var FALL_GRAVITY = 600
var FORCE_FALL = 350
var JUMP_BUFFER = 0.1
var last_grounded: float = 0.0

var LRMovement = false
var buffer_elapsed: float

func _physics_process(delta: float) -> void:
	move_and_slide()
	position.x = POSITION
	
	# post-game
	if manager.end:
		velocity *= manager.end_multiplier
		sprite.speed_scale *= manager.end_multiplier
		return
	
	# gravity and animation speed
	if not is_on_floor():
		sprite.speed_scale = 0.5
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY * delta
		else:
			velocity.y += GRAVITY * delta
	else:
		sprite.speed_scale = 1.3
		last_grounded = position.y
	
	_jump_process(delta)

func _jump_process(delta: float):
	# Jump Buffer Stuff
	buffer_elapsed -= 1 * delta;
	if Input.is_action_just_pressed("Jump"):
		buffer_elapsed = JUMP_BUFFER
	if is_on_floor() && buffer_elapsed > 0:
		velocity.y = JUMP_VELOCITY
	
	# force fall stuff
	if Input.is_action_just_pressed("Down"):
		velocity.y = FORCE_FALL
	
	# Stretch Jump Stuff
	if Input.is_action_just_released("Jump") && velocity.y < 0:
		velocity.y *= 0.5

func death():
	var death_instance = DEATH_SCREEN.instantiate()
	manager.add_child(death_instance)
	manager.end = true
	manager.death_screen = death_instance
