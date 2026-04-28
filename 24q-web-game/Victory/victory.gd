extends Control

@export_file_path("*.tscn") var main_menu : String
@export_file_path("*.tscn") var credits_menu : String


func _on_quit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	if credits_menu and not credits_menu.is_empty():
		get_tree().change_scene_to_file.call_deferred(credits_menu)
	else:
		print("Error: credits_menu is not set or empty")


func _on_main_menu_pressed():
	if main_menu and not main_menu.is_empty():
		get_tree().change_scene_to_file.call_deferred(main_menu)
	else:
		print("Error: main_menu is not set or empty")
