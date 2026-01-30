extends Node

var in_meltdown:bool = true

func start_meltdown():
	in_meltdown = true
	var meltdown_timer = get_tree().get_first_node_in_group("Meltdown_Timer") as Timer
	var meltdown_bar = get_tree().get_first_node_in_group("Meltdown_Bar") as ProgressBar #TODO: REPLACE WITH TEXTURE PROGRESS BAR
	meltdown_bar.value = 0
	
	if meltdown_timer.paused:
		meltdown_timer.paused = false
	else:
		meltdown_timer.stop()
		meltdown_timer.start()





func stop_meltdown():
	in_meltdown = false
	var meltdown_timer = get_tree().get_first_node_in_group("meltdown_timer") as Timer
	meltdown_timer.paused = true

func game_over() -> void:
	print("Game Over")
	get_tree().quit()
