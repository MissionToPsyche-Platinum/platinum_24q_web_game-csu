extends Node


var in_meltdown:bool = false

const game_over_menu = "res://Game Over/game_over.tscn"
const victory_menu = "res://Victory/victory.tscn"

var meltdown_timer : Timer
var meltdown_bar : TextureProgressBar
var meltdown_warning_label : Label


var in_minigame_state : bool = false:
	set(value):
		var player : Player_Character = get_tree().get_first_node_in_group("Player")
		var camera_dim : ColorRect = get_tree().get_first_node_in_group("Camera_Dim")
		if value == true:
			player.in_minigame = true
			camera_dim.visible = true
			
		if value == false:
			player.in_minigame = false
			camera_dim.visible = false

		in_minigame_state = value
	
	get:
		return in_minigame_state


func start_meltdown():
	process_mode = Node.PROCESS_MODE_ALWAYS
	in_meltdown = true

	#For future reference: Station Manager checks if these meltdown variables are setup as a sign that this function has ran before
	meltdown_timer = get_tree().get_first_node_in_group("Meltdown_Timer") as Timer
	meltdown_bar = get_tree().get_first_node_in_group("Meltdown_Bar") as TextureProgressBar
	meltdown_bar.visible = true
	
	meltdown_bar.value = 0
	meltdown_warning_label = get_tree().get_first_node_in_group("Station_Warning_Label")
	
	if meltdown_timer.paused:
		meltdown_timer.paused = false
	else:
		meltdown_timer.stop()
		meltdown_timer.start()




func pause_meltdown():
	in_meltdown = false
	meltdown_timer.paused = true
	meltdown_bar.visible = false

func resume_meltdown():
	if !meltdown_timer or !meltdown_bar or !meltdown_warning_label: #If the meltdown UI hasn't been setup then Meltdown never started
		start_meltdown()
	else: 
		in_meltdown = true
		meltdown_timer.paused = false
		meltdown_bar.visible = true

	
func game_over() -> void:
	print("Game Over")
	
	if game_over_menu and not game_over_menu.is_empty():
		get_tree().change_scene_to_file.call_deferred(game_over_menu)
	else:
		print("Error: game_scene is not set or empty")


func victory() -> void:
	print("You Win!!")
	
	if victory_menu and not victory_menu.is_empty():
		get_tree().change_scene_to_file.call_deferred(victory_menu)
	else:
		print("Error: victory_menu is not set or empty")
