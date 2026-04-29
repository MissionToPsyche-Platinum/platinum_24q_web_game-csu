extends Minigame

@export var goal := 10

@export var gravity_min := 200.0
@export var gravity_max := 500.0
@export var gravity_burst_time := 0.3
@export var gravity_interval_min := 0.5
@export var gravity_interval_max := 2.0

var collected := 0
var center := Vector2.ZERO

var fact_index := 0
var facts := [
	"Psyche could be part of the metal-rich interior of a planetesimal, a building block of a rocky planet.",
	"The spacecraft’s multispectral imager will provide information about the mineral composition of Psyche as well as its topography.",
	"By analyzing the X-band radio waves the spacecraft communicates with, scientists can measure how Psyche affects the spacecraft’s orbit.",
	"The full flight system, including the spacecraft’s twin five-panel solar arrays, is about the size of a singles tennis court",
	"The asteroid is most likely a survivor of multiple violent hit-and-run collisions, common when the solar system was forming.",
	"The shape of the asteroid Psyche is irregular and potatolike. If it were sliced in half horizontally at the equator – picture a squished oval – the asteroid would measure 173 miles across at its widest point.",
	]

@onready var player = $M_Player
@onready var circle = $G_Circle
@onready var spawner = $Data_Spawner
@onready var ui = $Control/VBoxContainer/DataCounter
@onready var facts_label = $Control/VBoxContainer/FactsLabel
@onready var data_spawner = $Data_Spawner
@onready var success: AudioStreamPlayer2D = $success


func setup(size: Vector2):

	
	center = circle.position
	player.position = center


	spawner.center = center
	spawner.radius = circle.circle_shape.shape.radius
	print(spawner.radius)

	update_ui()

	start_loops()



func start_loops():
	spawn_loop()
	gravity_loop()


func spawn_loop():
	while true:
		await get_tree().create_timer(1.0).timeout
		if data_spawner.all_data.size() < 10:
			var data = spawner.spawn()
			data.connect("collected", _on_collected)



func gravity_loop():
	while true:
		await get_tree().create_timer(randf_range(gravity_interval_min, gravity_interval_max)).timeout

		var dir = Vector2.RIGHT.rotated(randf() * TAU)
		player.gravity_force = dir * randf_range(gravity_min, gravity_max)

		await get_tree().create_timer(gravity_burst_time).timeout
		player.gravity_force = Vector2.ZERO



func _on_collected():
	collected += 1
	update_ui()
	show_fact()

	if collected >= goal:
		complete()


func complete():
	success.play()
	await success.finished
	emit_signal("completed")


func update_ui():
	ui.text = "Data: %d / %d" % [collected, goal]


func show_fact():
	if facts.size() == 0:
		return
	
	if collected % 2 == 1:
		facts_label.text = facts[fact_index]

		fact_index += 1
		if fact_index >= facts.size():
			fact_index = 0  # loop facts

func fail():
	emit_signal("failed")
