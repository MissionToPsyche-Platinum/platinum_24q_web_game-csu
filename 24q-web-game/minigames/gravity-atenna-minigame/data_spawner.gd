extends Node2D

@export var data_scene: PackedScene
@export var radius := 250.0
@export var center := Vector2.ZERO

@onready var container = $Data_Container
var all_data : Array[Gravity_Data] = []


func spawn():
	var angle = randf() * TAU
	var dist = randf() * radius * 0.8

	var pos = center + Vector2.RIGHT.rotated(angle) * dist

	var data = data_scene.instantiate()
	data.position = pos

	all_data.append(data)
	container.add_child(data)
	
	return data
