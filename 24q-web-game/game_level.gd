extends Node2D

@onready var progress_timer = %"Progress Timer" as Progress_Timer
@onready var progress_bar = get_tree().get_first_node_in_group("Progress_Bar") as TextureProgressBar

@onready var meltdown_timer = get_tree().get_first_node_in_group("Meltdown_Timer") as Timer
@onready var meltdown_bar = get_tree().get_first_node_in_group("Meltdown_Bar") as TextureProgressBar
@onready var music = $Music

var station_manager : Station_Manager


func _ready() -> void:
	#Game_State_Manager.start_meltdown()
	
	progress_timer.connect("progress_timeout", _on_progress_timer_timeout)
	
	station_manager = get_tree().get_first_node_in_group("Station_Parent") as Station_Manager
	station_manager.update_warning_label()

func _process(delta):
	
	if Game_State_Manager.in_meltdown:
		update_meltdown_progress_bar()
	
	#Update Game Progress Regardless
	update_game_progress_bar()



func update_game_progress_bar():	
	if station_manager.get_all_broken_stations().size() != station_manager.stations.size():
		
		if !progress_timer.has_started:
			progress_timer.has_started = true
		
		if !progress_timer.paused:
			progress_timer.paused = false
		
		#print("broken count:", station_manager.get_all_broken_stations().size())
		#print("station count:", station_manager.stations.size())
		
		var progress_rate : float = 1 - (float(station_manager.get_all_broken_stations().size()) / float(station_manager.stations.size()))
		
		#print("progress scaling: ", progress_rate )
		
		progress_timer.speed_scale = progress_rate
		
		progress_bar.value = (progress_timer.elapsed / progress_timer.duration) * progress_bar.max_value
	else:
		progress_timer.paused = true



func update_meltdown_progress_bar():
	# Calculate progress: (time left / total time)
	# Subtract from 1.0 to make it fill as time *decreases*
	var progress_ratio = (meltdown_timer.wait_time - meltdown_timer.time_left) / meltdown_timer.wait_time
	meltdown_bar.value = 100 - (progress_ratio * 100) # Set as percentage (0-100)

func _on_meltdown_timer_timeout() -> void:
	Game_State_Manager.game_over()


func _on_progress_timer_timeout() -> void:
	Game_State_Manager.victory()
