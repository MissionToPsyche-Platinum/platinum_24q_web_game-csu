extends CharacterBody2D

@export var speed : float = 400.0
@onready var animated_sprite = $Player
@onready var walk_metal = $Walk_Sounds

func _physics_process(delta):
	var direction = Vector2.ZERO
	
<<<<<<< HEAD
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

=======
	# Get input for both axes
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	# Normalize so diagonal movement isn't faster
	if direction != Vector2.ZERO:
		direction = direction.normalized()
		velocity = direction * speed
		
		# Animation handling
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				animated_sprite.play("right_walk")
			else:
				animated_sprite.play("left_walk")
		else:
			if direction.y > 0:
				animated_sprite.play("down_walk")
			else:
				animated_sprite.play("up_walk")
	else:
		# Smooth stop
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		animated_sprite.stop()
		# or: animated_sprite.play("idle")
	
>>>>>>> 0bb3976899526c2b2c0c51f5c2a348a405358497
	move_and_slide()
