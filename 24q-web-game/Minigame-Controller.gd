class_name Minigame_Controller
extends Node
signal minigame_completed

@export var minigame_scene: PackedScene

@onready var viewport = $CanvasLayer/Control/SubViewportContainer/SubViewport
@onready var canvas_layer = $CanvasLayer
@onready var container = $CanvasLayer/Control/SubViewportContainer

var current_minigame = null

func start_minigame():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	
	
	if minigame_scene == null:
		push_error("No minigame assigned!")
		return
	
	
	var screen_size = get_viewport().get_visible_rect().size
	var size = screen_size * 0.5

	viewport.size = size
	container.custom_minimum_size = size

	current_minigame = minigame_scene.instantiate()
	viewport.add_child(current_minigame)

	# Connect dynamically
	if current_minigame is Minigame:
		current_minigame.connect("completed", Callable(self, "_on_minigame_completed"))

	canvas_layer.visible = true
	get_tree().paused = true  # optional - Possible problem

func _on_minigame_completed():
	emit_signal("minigame_completed")
	stop_minigame()

func stop_minigame():
	if current_minigame:
		current_minigame.queue_free()
		current_minigame = null

	canvas_layer.visible = false
	get_tree().paused = false
