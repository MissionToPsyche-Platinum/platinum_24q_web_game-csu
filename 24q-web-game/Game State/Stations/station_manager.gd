extends Node
class_name Station_Manager

var stations: Array[Station] = []

#TODO: Add functionality that timer speeds up if all staions are broken

func _ready():
	
	for station in get_children():
		if station is Station:
			stations.append(station)
	
	for setup in stations:
		setup.station_status.connect(check_stations_status) # Whenever the Station status signal goes off
	
	if !get_all_broken_stations().is_empty():
		Game_State_Manager.resume_meltdown()
	
	
	

func check_stations_status(name : String, status : bool):
	
	if status == false: #Means a station is just broke
		Game_State_Manager.resume_meltdown() #resume meltdown
		update_warning_label()
		
	else: #A Station was fixed
		
		if get_all_broken_stations().is_empty(): # If all stations are fixed
			Game_State_Manager.pause_meltdown()
			update_warning_label()
		else: #If only one of multiple broken stations were fixed
			Game_State_Manager.resume_meltdown()
			update_warning_label()
	

func get_all_broken_stations():
	var broken_stations: Array[Station] = []
	
	for station in stations:
		if not station.is_fixed:
			broken_stations.append(station)
	
	return broken_stations


func update_warning_label():
	
	if get_all_broken_stations().is_empty():
		Game_State_Manager.meltdown_warning_label.text = "All Stations are functioning"
	else:
		var new_warning_label : String = "ALERT: " #update warning label under meltdown_bar
		
		var broken_stations: Array[Station] = get_all_broken_stations()
		
		for broken in broken_stations:
			new_warning_label = new_warning_label + broken.name + ", " #Adds all of the broken stations to the label
		
		new_warning_label = new_warning_label.left(new_warning_label.length() - 2) #Sets the label to everything but the last two characters to get rid of the ", " after the last list item
		new_warning_label = new_warning_label + " are broken!"
		
		Game_State_Manager.meltdown_warning_label.text = new_warning_label
