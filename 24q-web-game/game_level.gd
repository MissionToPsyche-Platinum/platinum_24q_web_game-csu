extends Node2D


@onready var meltdown_timer = get_tree().get_first_node_in_group("Meltdown_Timer") as Timer
@onready var meltdown_bar = get_tree().get_first_node_in_group("Meltdown_Bar") as TextureProgressBar



func _ready() -> void:
	#Game_State_Manager.start_meltdown()
	
	var station_manager = get_tree().get_first_node_in_group("Station_Parent") as Station_Manager
	station_manager.update_warning_label()

func _process(delta):
	
	if Game_State_Manager.in_meltdown:
		update_meltdown_progress_bar()



func update_meltdown_progress_bar():
	# Calculate progress: (time left / total time)
	# Subtract from 1.0 to make it fill as time *decreases*
	var progress_ratio = (meltdown_timer.wait_time - meltdown_timer.time_left) / meltdown_timer.wait_time
	meltdown_bar.value = 100 - (progress_ratio * 100) # Set as percentage (0-100)

func _on_meltdown_timer_timeout() -> void:
	Game_State_Manager.game_over()
	
