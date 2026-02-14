extends Node

var in_meltdown:bool = true

const game_over_menu = "res://Game Over/game_over.tscn"

func start_meltdown():
	in_meltdown = true
	var meltdown_timer = get_tree().get_first_node_in_group("Meltdown_Timer") as Timer
	var meltdown_bar = get_tree().get_first_node_in_group("Meltdown_Bar") as TextureProgressBar #TODO: REPLACE WITH TEXTURE PROGRESS BAR
	meltdown_bar.value = 0
	
	if meltdown_timer.paused:
		meltdown_timer.paused = false
	else:
		meltdown_timer.stop()
		meltdown_timer.start()



func pause_meltdown():
	in_meltdown = false
	var meltdown_timer = get_tree().get_first_node_in_group("meltdown_timer") as Timer
	meltdown_timer.paused = true

func resume_meltdown():
	in_meltdown = true
	var meltdown_timer = get_tree().get_first_node_in_group("meltdown_timer") as Timer
	meltdown_timer.paused = false

func game_over() -> void:
	print("Game Over")
	
	if game_over_menu and not game_over_menu.is_empty():
		get_tree().change_scene_to_file.call_deferred(game_over_menu)
	else:
		print("Error: game_scene is not set or empty")
