extends CharacterBody2D

@export var speed : float = 300.0
@onready var animated_sprite = $Player

func _physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction > 0:
		# Moving right
		velocity.x = speed
		animated_sprite.play("right_walk")
		
	elif direction < 0:
		# Moving left
		velocity.x = -speed
		animated_sprite.play("left_walk")
		
	else:
		# Not moving
		velocity.x = move_toward(velocity.x, 0, speed)
		animated_sprite.stop()
		# Or use an idle animation:
		# animated_sprite.play("idle")
	
	move_and_slide()
