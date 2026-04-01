class_name Minigame_Controller
extends Node
signal minigame_completed

@export var minigame_scene: PackedScene  # swap per instance

@onready var viewport = $CanvasLayer/Control/SubViewportContainer/SubViewport
@onready var canvas_layer = $CanvasLayer

var current_minigame = null

func start_minigame():
	if minigame_scene == null:
		push_error("No minigame assigned!")
		return

	current_minigame = minigame_scene.instantiate()
	viewport.add_child(current_minigame)

	# Connect dynamically
	if current_minigame.has_signal("completed"):
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
