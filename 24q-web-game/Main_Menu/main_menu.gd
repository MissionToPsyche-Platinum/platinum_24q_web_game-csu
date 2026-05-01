extends Control

@export_file_path("*.tscn") var story_scene : String
@export_file_path("*.tscn") var credits : String



func _on_start_pressed():
	if story_scene and not story_scene.is_empty():
		get_tree().change_scene_to_file.call_deferred(story_scene)
	else:
		print("Error: story_scene is not set or empty")



func _on_quit_pressed():
	get_tree().quit()


func _on_credits_pressed():
	if credits and not credits.is_empty():
		get_tree().change_scene_to_file.call_deferred(credits)
	else:
		print("Error: credits is not set or empty")
