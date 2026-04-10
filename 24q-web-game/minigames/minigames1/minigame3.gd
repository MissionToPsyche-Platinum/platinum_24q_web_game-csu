extends Node2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var button1: Area2D = $AnimatedSprite2D/Button1
@onready var button2: Area2D = $AnimatedSprite2D/Button2
@onready var button3: Area2D = $AnimatedSprite2D/Button3
@onready var button4: Area2D = $AnimatedSprite2D/Button4
@onready var correctArray = [4, 1, 2, 3]
@onready var answerArray = []
@onready var i = 0
@onready var click = $click
@onready var error = $error
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_1_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(1)
		if answerArray[i] != correctArray[i]:
			#If the wrong button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			i = 0
			answerArray.clear()
		else:
			click.play()
			sprite.set_frame_and_progress(2, 2)
			i = i + 1 
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			print('done')


func _on_button_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(2)
		if answerArray[i] != correctArray[i]:
			#If the wrong button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			i = 0
			answerArray.clear()
		else:
			click.play()
			sprite.set_frame_and_progress(3, 3)
			i = i + 1 
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			print('done')


func _on_button_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(3)
		if answerArray[i] != correctArray[i]:
			#If the wrong button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			i = 0
			answerArray.clear()
		else:
			click.play()
			sprite.set_frame_and_progress(4, 4)
			i = i + 1 
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			print('done')


func _on_button_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(4)
		if answerArray[i] != correctArray[i]:
			#If the wrong button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			i = 0
			answerArray.clear()
		else:
			click.play()
			sprite.set_frame_and_progress(1, 1)
			i = i + 1 
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			print('done')
