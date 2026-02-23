extends Control

@export_file_path("*.tscn") var game_scene : String



func _on_start_pressed():
	if game_scene and not game_scene.is_empty():
		get_tree().change_scene_to_file.call_deferred(game_scene)
	else:
		print("Error: game_scene is not set or empty")



func _on_quit_pressed():
	get_tree().quit()
