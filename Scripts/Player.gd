extends CharacterBody2D

@onready var pumped_sprite: AnimatedSprite2D = $Pumped
@onready var flat_sprite: AnimatedSprite2D = $Flat
var sprite: AnimatedSprite2D

@onready var manager: Node2D = %Manager
@onready var collider: CollisionShape2D = $CollisionShape2D
@onready var cam: Camera2D = %Camera2D

const DEATH_SCREEN = preload("res://Scenes/death_screen.tscn")

var POSITION = -50.0
var SPEED = 1
var JUMP_VELOCITY = -200
var AIR_JUMP_VELOCITY = -225
var GRAVITY = 600
var FALL_GRAVITY = 800
var FORCE_FALL = 350
var JUMP_BUFFER = 0.1
var COYOTE_TIME = 0.2
var INITIAL_HEALTH = 70.0
var INITIAL_AIR = 280
var MAX_AIR = 400
var DOUBLEJUMP_COST = 16
var FORCEFALL_COST = 1

var last_grounded: float = 0.0
var ground_level: float = 0.0
var buffer_elapsed: float = 0.0
var coyote_elapsed: float = 0.0
var air: int = 0
var health: float = 0.0
var diff: float = 0.0
var has_doublejumped: bool = false
var begin = false
var rising = false

var jump = false
var doublejump = false
var forcefall = false

func _ready() -> void:
	air = INITIAL_AIR
	health = INITIAL_HEALTH

func _physics_process(delta: float) -> void:
	if !begin || manager.paused: return
	
	move_and_slide()
	position.x = lerp(position.x, POSITION, SPEED * delta)
	health += diff
	print(velocity.y)
	
	if manager.elevation <= 0.0 && !manager.end:
		death()
	
	if air <= 0:
		sprite = flat_sprite
		sprite.play()
		pumped_sprite.visible = false
		flat_sprite.visible = true
		collider.shape.radius = 4.0
		
		if is_on_floor(): 
			diff -= 0.05 * delta
		else:
			diff = 0.0
	else:
		sprite = pumped_sprite
		sprite.play()
		pumped_sprite.visible = true
		flat_sprite.visible = false
		collider.shape.radius = 8.0
		
		diff = 0.0
	
	if air >= MAX_AIR || health <= 0.0 || manager.game_speed < 0.0:
		if !manager.end && !manager.pregame:
			death()
	
	# post-game
	if manager.end:
		velocity *= manager.end_multiplier
		sprite.speed_scale *= manager.end_multiplier
		return
	
	# gravity and animation speed
	if !is_on_floor():
		coyote_elapsed -= delta
		
		sprite.speed_scale = manager.game_speed * 0.005 * 0.8
		if velocity.y > 0:
			velocity.y += FALL_GRAVITY * delta
		else:
			velocity.y += GRAVITY * delta
	else:
		sprite.speed_scale = manager.game_speed * 0.005 * 1.3
		last_grounded = position.y
		coyote_elapsed = COYOTE_TIME
		has_doublejumped = false
	
	_jump_process(delta)

func _jump_process(delta: float):
	buffer_elapsed -= 1 * delta
	
	var jump_pressed = Input.is_action_just_pressed("Jump")
	
	if jump_pressed: 
		buffer_elapsed = JUMP_BUFFER
	
	if coyote_elapsed > 0.0:
		# First Jump
		if buffer_elapsed > 0.0:
			velocity.y = JUMP_VELOCITY
			buffer_elapsed = 0.0
			coyote_elapsed = 0.0
			jump = true
	elif jump_pressed && !has_doublejumped && !Input.is_action_pressed("Down") && air >= DOUBLEJUMP_COST:
		# Double Jump
		air -= DOUBLEJUMP_COST
		velocity.y = AIR_JUMP_VELOCITY
		has_doublejumped = true
		doublejump = true
	
	# force fall stuff
	if Input.is_action_just_pressed("Down") && velocity.y < FORCE_FALL && !is_on_floor() && air >= FORCEFALL_COST:
		air -= FORCEFALL_COST
		velocity.y = FORCE_FALL
		forcefall = true
	
	# Stretch Jump Stuff (initial jump only)
	if Input.is_action_just_released("Jump") && velocity.y < 0 && !has_doublejumped:
		velocity.y *= 0.5

func death():
	if air > 0 || manager.elevation > 0.0:
		sprite.visible = false
		var deathSprite = $DeathAnimation
		deathSprite.visible = true
		deathSprite.play("Die")
		
		velocity.y = -350
	
	var death_instance = DEATH_SCREEN.instantiate()
	manager.add_child(death_instance)
	manager.end = true
	manager.death_screen = death_instance
