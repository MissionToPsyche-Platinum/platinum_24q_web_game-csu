class_name Player_Character
extends CharacterBody2D

@export var speed : float = 300.0
@onready var animated_sprite = $Player
@onready var walk_metal = $Walk_Sounds
@onready var interacting_component = $"Interacting Component"

var in_minigame : bool = false:
	set(value):
		in_minigame = value
		set_physics_process(!in_minigame)
	get:
		return in_minigame


func _physics_process(delta):
	
	if !in_minigame:
		var direction_x = Input.get_axis("ui_left", "ui_right")
		var direction_y = Input.get_axis("ui_up", "ui_down")
		
		velocity.x = direction_x * speed
		velocity.y = direction_y * speed
		
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
		else:
			animated_sprite.stop()
			walk_metal.stop()
		
		move_and_slide()
