extends Control

@export_file_path("*.tscn") var main_menu : String



func _on_button_pressed():
	if main_menu and not main_menu.is_empty():
		get_tree().change_scene_to_file.call_deferred(main_menu)
	else:
		print("Error: main_menu is not set or empty")
