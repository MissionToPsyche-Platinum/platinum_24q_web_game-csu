extends CharacterBody2D

@export var speed : float = 300.0
@onready var animated_sprite = $Player

func _physics_process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	# Apply velocity
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed
	
	# Play animations based on direction
	# Priority: check which direction has input
	if direction_y < 0:
		# Moving up
		animated_sprite.play("up-forward")
	elif direction_y > 0:
		# Moving down
		animated_sprite.play("down-foward")
	elif direction_x > 0:
		# Moving right
		animated_sprite.play("right_walk")
	elif direction_x < 0:
		# Moving left
		animated_sprite.play("left_walk")
	else:
		# Not moving
		animated_sprite.stop()
		# Or use idle: animated_sprite.play("idle")
	
	move_and_slide()
