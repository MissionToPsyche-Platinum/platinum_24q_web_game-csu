class_name Station
extends StaticBody2D

signal station_status(name, status : bool)

@export var is_fixed = false
@export var station_name : String = "default name"

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
# This is what is called when a player interacts with an object
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	
func _on_interact():
	interactable.is_interactable = false
	print("The play is working on a station")
	
	station_finished() #TODO: MOVE THIS TO AFTER THEY HAVE FINISHED TASK

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func station_finished():
	is_fixed = true
	station_status.emit(station_name, is_fixed)
