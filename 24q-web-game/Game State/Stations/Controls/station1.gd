extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var solar: CanvasLayer = $"../CharacterBody2D/Camera2D/solarLayer"
# This is what is called when a player interacts with an object
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable.interact = _on_interact
	solar.hide()
	
func _on_interact():
	interactable.is_interactable = false
	solar.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_minigame_2_minigame_2_done() -> void:
	solar.hide()
