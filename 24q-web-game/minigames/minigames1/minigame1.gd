extends Node
@onready var button1: Area2D = $AnimatedSprite2D/Button1
@onready var button2: Area2D = $AnimatedSprite2D/Button2
@onready var button3: Area2D = $AnimatedSprite2D/Button3
@onready var button4: Area2D = $AnimatedSprite2D/Button4
@onready var correctArray = [2, 4, 1, 3]
@onready var answerArray = []
@onready var i = 0
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
			print("Wrong")
			i = 0
			answerArray.clear()
		else:
			i = i + 1 
		print(answerArray)
		


func _on_button_2_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(2)
		if answerArray[i] != correctArray[i]:
			print("Wrong")
			i = 0
			answerArray.clear()
		else:
			i = i + 1
		print(answerArray)


func _on_button_3_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(3)
		if answerArray[i] != correctArray[i]:
			print("Wrong")
			i = 0
			answerArray.clear()
		else:
			i = i + 1
		print(answerArray)


func _on_button_4_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		answerArray.append(4)
		if answerArray[i] != correctArray[i]:
			print("Wrong")
			i = 0
			answerArray.clear()
		else:
			i = i + 1
		print(answerArray)
