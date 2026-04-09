class_name Station
extends StaticBody2D

signal station_status(name, status : bool)

@export var is_fixed = false
@export var station_name : String = "default name"

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var minigame_controller = $MinigameController

# This is what is called when a player interacts with an object
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	minigame_controller.connect("minigame_completed", Callable(self, "_on_minigame_done"))
	
	
func _on_interact():
	print("The play is working on a station")
	interactable.is_interactable = false
	minigame_controller.start_minigame()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_minigame_done():
	print("Interaction complete!")
	station_finished()

func station_finished():
	is_fixed = true
	station_status.emit(station_name, is_fixed)
