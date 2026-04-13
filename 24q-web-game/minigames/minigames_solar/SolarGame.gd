extends Node2D

@onready var sun = $Sun
@onready var satellite = $Satellite
@onready var panels = $Satellite/SolarPanels
@onready var power_bar = $CanvasLayer/Control/ProgressBar
@onready var beam = $Beam

var angle = 0.0
var speed = 0.2
var arc_width = 200.0
var arc_height = 60.0

var power = 50.0  
var max_power = 100.0
var drain_rate = 4.0      
var charge_rate = 8.0  
var alignment_threshold = 0.6  

# 1=ping pong effect, 0 = full 360
var pp = 1
var low_power_alert = false
signal solarMinigameDone

func _ready():
	power_bar.min_value = 0
	power_bar.max_value = 100
	power_bar.value = power

func _process(delta):
	# Move sun
	angle += speed * delta
	
	var arc_angle
	if pp:
		arc_angle = PI - abs(fmod(angle, PI * 2) - PI)
	else:
		arc_angle = angle
		
	var arc_center = Vector2(256, 130)
	sun.global_position = arc_center + Vector2(
		cos(arc_angle) * -arc_width,
		sin(arc_angle) * -arc_height)

	# Calculate alignment
	var to_sun = sun.global_position - panels.global_position
	var sun_angle = rad_to_deg(atan2(to_sun.x, -to_sun.y))
	var diff = abs(sun_angle - panels.rotation_degrees)
	var alignment = clamp(1.0 - diff / 35.0, 0.0, 1.0)

	if alignment >= alignment_threshold:
		power = min(power + charge_rate * alignment * delta, max_power)
		power_bar.modulate = Color.GREEN
	else:
		power = max(power - drain_rate * delta, 0.0)
		power_bar.modulate = Color.RED

	power_bar.value = power
	
	if power <= 25 and not low_power_alert:
		low_power_alert = true
		_on_low_power()
	elif power > 25:
		low_power_alert = false

	if power >= max_power:
		_on_fully_charged()
	elif power <= 0.0:
		_on_power_lost()
		
	beam.update_beam(panels.global_position, sun.global_position, alignment)

func _on_fully_charged():
	power_bar.modulate = Color.CYAN
	emit_signal("solarMinigameDone")
	print("full power")
	
func _on_low_power():
	power_bar.modulate = Color.ORANGE
	print("low power alert")

func _on_power_lost():
	power_bar.modulate = Color.DARK_RED
	print("lost power")

func _on_h_slider_value_changed(value: float) -> void:
	panels.rotation_degrees = value

func _on_button_pressed() -> void:
	get_tree().quit()
