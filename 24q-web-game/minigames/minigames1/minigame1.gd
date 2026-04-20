extends Node
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var button1: Area2D = $AnimatedSprite2D/Button1
@onready var button2: Area2D = $AnimatedSprite2D/Button2
@onready var button3: Area2D = $AnimatedSprite2D/Button3
@onready var button4: Area2D = $AnimatedSprite2D/Button4
@onready var ALabel: Label = $AnimatedSprite2D/Button1/A2
@onready var BLabel: Label = $AnimatedSprite2D/Button2/B2
@onready var CLabel: Label = $AnimatedSprite2D/Button3/C2
@onready var DLabel: Label = $AnimatedSprite2D/Button4/D2
@onready var labelArray: Array = [ALabel, BLabel, CLabel, DLabel]
@onready var correctArray = [2, 4, 1, 3]
@onready var answerArray = []
@onready var i = 0
@onready var click = $click
@onready var error = $error
@onready var success = $success
signal minigameDone
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
			show_all_labels()
			i = 0
			answerArray.clear()
		else:
			click.play()
			ALabel.hide()
			sprite.set_frame_and_progress(3, 3)
			i = i + 1 
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			emit_signal("minigameDone")
			answerArray.clear()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			success.play()
			print('done')
		


func _on_button_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(2)
		if answerArray[i] != correctArray[i]:
			#If wrong button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			answerArray.clear()
		else:
			click.play()
			BLabel.hide()
			sprite.set_frame_and_progress(1, 1)
			i = i + 1
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			emit_signal("minigameDone")
			answerArray.clear()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			success.play()

			print('done')


func _on_button_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(3)
		if answerArray[i] != correctArray[i]:
			#If the wrong button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			answerArray.clear()
		else:
			click.play()
			CLabel.hide()
			sprite.set_frame_and_progress(4, 4)
			i = i + 1
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			emit_signal("minigameDone")
			answerArray.clear()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			success.play()
			print('done')


func _on_button_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(4)
		if answerArray[i] != correctArray[i]:
			#If the wrong  button is pressed
			error.play()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			answerArray.clear()
		else:
			click.play()
			DLabel.hide()
			sprite.set_frame_and_progress(2, 2)
			i = i + 1
		print(answerArray)
		if answerArray == correctArray:
			#This is when the minigame is done
			emit_signal("minigameDone")
			answerArray.clear()
			sprite.set_frame_and_progress(0, 0)
			show_all_labels()
			i = 0
			success.play()
			print('done')
			
			
func show_all_labels() -> void:
	for label in labelArray:
		label.show()

	
	
