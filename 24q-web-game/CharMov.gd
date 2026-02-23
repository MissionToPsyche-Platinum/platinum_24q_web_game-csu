extends CharacterBody2D

@export var speed : float = 300.0
@onready var animated_sprite = $Player
@onready var walk_metal = $Walk_Sounds

func _physics_process(delta):
	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = Input.get_axis("ui_up", "ui_down")
	
	velocity.x = direction_x * speed
	velocity.y = direction_y * speed
	
<<<<<<< HEAD
	if direction_y < 0:
		animated_sprite.play("up-forward")
		if not walk_metal.playing:
			walk_metal.play()
	elif direction_y > 0:
		animated_sprite.play("down-foward")
		if not walk_metal.playing:
			walk_metal.play()
	elif direction_x > 0:
		animated_sprite.play("right_walk")
		if not walk_metal.playing:
			walk_metal.play()
	elif direction_x < 0:
		animated_sprite.play("left_walk")
		if not walk_metal.playing:
			walk_metal.play()
=======
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
>>>>>>> origin/master
	else:
		animated_sprite.stop()
		walk_metal.stop()
	
	move_and_slide()
