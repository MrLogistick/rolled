extends Node2D

@onready var manager: Node2D = %Manager
@onready var player: CharacterBody2D = %Player
@onready var canvas_layer: CanvasLayer = %CanvasLayer
var tutorials = [
	preload("res://Scenes/jump_tutorial.tscn"),
	preload("res://Scenes/doublejump_tutorial.tscn"),
	preload("res://Scenes/forcefall_tutorial.tscn")
]

var spawned = false
var tutorial
var current_tutorial = 0

func _process(delta: float) -> void:
	if !player.begin || current_tutorial >= 5 || manager.paused: return
	
	if !Global.tutorial:
		spawned = false
		current_tutorial = 5
		player.air = player.INITIAL_AIR
		player.health = player.INITIAL_HEALTH
		manager.pregame = false
		
		if tutorial:
			tutorial.queue_free()
	
	if !spawned && current_tutorial <= 2:
		tutorial = tutorials[current_tutorial].instantiate()
		tutorial.position = Vector2(0, -75)
		add_child(tutorial)
		spawned = true
	
	# Jump Tutorial
	if player.jump && current_tutorial == 0:
		spawned = false
		current_tutorial += 1
		tutorial.queue_free()
		player.air = player.FORCEFALL_COST + player.DOUBLEJUMP_COST
		canvas_layer.get_child(1).visible = true
	
	# Double Jump Tutorial
	if player.doublejump && current_tutorial == 1:
		spawned = false
		current_tutorial += 1
		tutorial.queue_free()
	
	# Force Fall Tutorial
	if player.forcefall && current_tutorial == 2:
		Engine.time_scale = 1.0
		spawned = false
		current_tutorial += 1
		tutorial.queue_free()
	
	# Health Tutorial
	if player.health <= player.INITIAL_HEALTH * 0.75 && current_tutorial == 3:
		current_tutorial += 1
	
	if (player.air > 0 || player.health <= 0.0) && current_tutorial == 4:
		player.air = player.INITIAL_AIR
		player.health = player.INITIAL_HEALTH
		manager.pregame = false
		Global.tutorial = false
	
	if player.doublejump && !player.forcefall || player.jump && !player.doublejump && Global.tutorial:
		if player.velocity.y > 0:
			Engine.time_scale = 0.05
		else:
			Engine.time_scale = 1.0
