extends CharacterBody2D

@export var speed : float = 400.0
@onready var animated_sprite = $Player

func _physics_process(delta):
	var direction = Vector2.ZERO
	
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
				animated_sprite.play("down-foward")
			else:
				animated_sprite.play("up-forward")
	else:
		# Smooth stop
		velocity = velocity.move_toward(Vector2.ZERO, speed)
		animated_sprite.stop()
		# or: animated_sprite.play("idle")
	
	move_and_slide()
