extends CharacterBody2D

@export var speed : float = 300.0
@onready var animated_sprite = $Player
@onready var walk_metal = $Walk_Sounds

func _physics_process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed

	# Animation
	if direction_y < 0:
		animated_sprite.play("up-forward")
	elif direction_y > 0:
		animated_sprite.play("down-foward")
	elif direction_x > 0:
		animated_sprite.play("right_walk")
	elif direction_x < 0:
		animated_sprite.play("left_walk")
	else:
		animated_sprite.stop()

	# Sound - play full audio, only restart if stopped
	if direction_x != 0 or direction_y != 0:
		if not walk_metal.playing:
			walk_metal.play()
	else:
		walk_metal.stop()

	move_and_slide()
