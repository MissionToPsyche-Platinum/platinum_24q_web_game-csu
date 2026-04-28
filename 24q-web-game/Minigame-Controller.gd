class_name Minigame_Controller
extends Node2D
signal minigame_completed

@export var minigame_scene: PackedScene

@onready var viewport = $CanvasLayer/SubViewportContainer/SubViewport
@onready var canvas_layer = $CanvasLayer
@onready var container = $CanvasLayer/SubViewportContainer


var current_minigame = null

func start_minigame():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	if minigame_scene == null:
		push_error("No minigame assigned!")
		return

	var global_player : Player_Character = get_tree().get_first_node_in_group("Player")


	var viewport_size = get_viewport_rect().size
	container.position = viewport_size / 2 - container.size / 2
	
	# Instantiate ONCE
	current_minigame = minigame_scene.instantiate()
	viewport.add_child(current_minigame)

	current_minigame.setup(container.custom_minimum_size)

	# Connect signal
	if current_minigame is Minigame:
		current_minigame.connect("completed", Callable(self, "_on_minigame_completed"))
		current_minigame.connect("failed", Callable(self, "_on_minigame_failed"))
	
	canvas_layer.visible = true
	Game_State_Manager.in_minigame_state = true

func _on_minigame_completed():
	emit_signal("minigame_completed")
	stop_minigame()

func stop_minigame():
	if current_minigame:
		current_minigame.queue_free()
		current_minigame = null
	canvas_layer.visible = false
	Game_State_Manager.in_minigame_state = false

func _on_minigame_failed():
	
	stop_minigame()
