extends Timer
class_name Progress_Timer

signal progress_timeout

var has_started: bool = false
var is_paused: bool = false
@export var duration : float = 120.0
@export var elapsed : float = 0.0
@export var speed_scale : float = 1.0

func _process(delta):
	if !is_paused and has_started:
		#print(speed_scale)
		elapsed += delta * speed_scale
		
		if elapsed >= duration:
			timeout()
			elapsed = 0.0  # or stop, depending on your use case

func timeout():
	emit_signal("progress_timeout")
	#print("Timer done")
