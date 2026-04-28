extends Area2D
class_name Gravity_Data

signal collected

func _on_entered(area: Node2D):
	#print("contact with data")
	if area is Minigame_Character:
		#print("contact with player")
		emit_signal("collected")
		queue_free()
