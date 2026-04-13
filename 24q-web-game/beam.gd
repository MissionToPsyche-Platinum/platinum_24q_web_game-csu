extends Node2D

var from = Vector2.ZERO
var to = Vector2.ZERO
var strength = 0.0

func update_beam(p_from: Vector2, p_to: Vector2, p_strength: float):
	from = p_from
	to = p_to
	strength = p_strength
	queue_redraw() 

func _draw():
	if strength <= 0.0:
		return
	
	var dir = (to - from).normalized()
	var perp = Vector2(-dir.y, dir.x)
	var spread = lerp(30.0, 100.0, strength)
	
	var tip = to
	var far = from - dir * 260.0  
	
	var color_outer = Color(1.0, 0.8, 0.0, strength * 0.08)
	var color_mid = Color(1.0, 0.9, 0.2, strength * 0.12)
	var color_core = Color(1.0, 1.0, 0.4, strength * 0.16)
	
	var spread_outer = spread * 1.6
	draw_colored_polygon([tip, far + perp * spread_outer, far - perp * spread_outer], color_outer)
	draw_colored_polygon([tip, far + perp * spread, far - perp * spread], color_mid)
	
	var spread_core = spread * 0.3
	draw_colored_polygon([tip, far + perp * spread_core, far - perp * spread_core], color_core)
