extends Area2D
class_name Minigame_Character

@export var speed: float = 200.0

var velocity: Vector2 = Vector2.ZERO
var gravity_force: Vector2 = Vector2.ZERO

func _process(delta):
	var input_dir = Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	).normalized()

	velocity = input_dir * speed + gravity_force
	position += velocity * delta
	
