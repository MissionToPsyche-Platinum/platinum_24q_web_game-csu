extends Node2D

const COLORS = [
	Color(0.886, 0.294, 0.290),
	Color(0.216, 0.541, 0.867),
	Color(0.937, 0.624, 0.153),
	Color(0.608, 0.561, 0.961),
]
const PLUG_R = 14.0
const SYMBOLS = ["circle", "square", "triangle", "cross"]

var spacing : float
var left_x  : float
var right_x : float
var start_y : float
var right_order : Array = []
var dragging    : int   = -1
var connected   : Array = []

@onready var drag_line: Line2D = $DragLine

func _ready():
	randomize()
	right_order = [0, 1, 2, 3]
	right_order.shuffle()
	drag_line.width          = 4.0
	drag_line.begin_cap_mode = Line2D.LINE_CAP_ROUND
	drag_line.end_cap_mode   = Line2D.LINE_CAP_ROUND
	drag_line.visible        = false
	_calc_layout()

func _calc_layout():
	var vp  = get_viewport_rect().size
	spacing = vp.y / 6.0
	left_x  = vp.x * 0.22
	right_x = vp.x * 0.78
	start_y = vp.y / 2.0 - spacing * 1.5

func _notification(what):
	if what == NOTIFICATION_WM_SIZE_CHANGED:
		_calc_layout()
		queue_redraw()

func lpos(ci: int) -> Vector2:
	return Vector2(left_x, start_y + ci * spacing)

func rpos(ci: int) -> Vector2:
	return Vector2(right_x, start_y + right_order.find(ci) * spacing)

func _draw():
	var vp = get_viewport_rect().size
	draw_rect(Rect2(0, 0, vp.x, vp.y), Color(0.04, 0.04, 0.06), true)
	for ci in 4:
		var done = ci in connected
		var col: Color = COLORS[ci]
		col.a = 0.35 if done else 1.0
		draw_circle(lpos(ci), PLUG_R, col)
		draw_circle(rpos(ci), PLUG_R, col)
		if not done:
			draw_circle(lpos(ci) + Vector2(-3, -3), PLUG_R * 0.35, Color(1, 1, 1, 0.2))
			draw_circle(rpos(ci) + Vector2(-3, -3), PLUG_R * 0.35, Color(1, 1, 1, 0.2))
		_draw_symbol(lpos(ci), ci, done)
		_draw_symbol(rpos(ci), ci, done)

func _draw_symbol(center: Vector2, ci: int, faded: bool):
	var sym_col := Color(1, 1, 1, 0.3 if faded else 0.9)
	var s       := PLUG_R * 0.52   # symbol scale

	match SYMBOLS[ci]:
		"circle":
			# hollow inner circle
			draw_arc(center, s, 0, TAU, 20, sym_col, 2.0)

		"square":
			var half := s * 0.82
			var pts  := PackedVector2Array([
				center + Vector2(-half, -half),
				center + Vector2( half, -half),
				center + Vector2( half,  half),
				center + Vector2(-half,  half),
				center + Vector2(-half, -half),   # close
			])
			draw_polyline(pts, sym_col, 2.0)

		"triangle":
			var h    := s * 1.1
			var pts  := PackedVector2Array([
				center + Vector2(0,       -h),
				center + Vector2( h * 0.9, h * 0.6),
				center + Vector2(-h * 0.9, h * 0.6),
				center + Vector2(0,       -h),    # close
			])
			draw_polyline(pts, sym_col, 2.0)

		"cross":
			draw_line(center + Vector2(-s,  0), center + Vector2( s, 0), sym_col, 2.0)
			draw_line(center + Vector2( 0, -s), center + Vector2( 0, s), sym_col, 2.0)

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			_try_start_drag(event.global_position)
		else:
			_try_drop(event.global_position)
	elif event is InputEventMouseMotion and dragging != -1:
		drag_line.set_point_position(1, event.global_position)

func _try_start_drag(pos: Vector2):
	for ci in 4:
		if ci in connected:
			continue
		if lpos(ci).distance_to(pos) <= PLUG_R + 6:
			dragging = ci
			drag_line.default_color = COLORS[ci]
			drag_line.clear_points()
			drag_line.add_point(lpos(ci))
			drag_line.add_point(lpos(ci))
			drag_line.visible = true
			return

func _try_drop(pos: Vector2):
	if dragging == -1:
		return
	drag_line.visible = false
	if rpos(dragging).distance_to(pos) <= PLUG_R + 10:
		_connect(dragging)
	dragging = -1

func _connect(ci: int):
	connected.append(ci)
	_draw_wire(ci)
	queue_redraw()

func _draw_wire(ci: int):
	var line            := Line2D.new()
	line.width           = 4.0
	line.default_color   = COLORS[ci]
	line.begin_cap_mode  = Line2D.LINE_CAP_ROUND
	line.end_cap_mode    = Line2D.LINE_CAP_ROUND
	var a  := lpos(ci)
	var b  := rpos(ci)
	var c1 := a + Vector2((b.x - a.x) * 0.4, 20)
	var c2 := b + Vector2((a.x - b.x) * 0.4, 20)
	for i in 25:
		var t := float(i) / 24.0
		var u := 1.0 - t
		line.add_point(u*u*u*a + 3*u*u*t*c1 + 3*u*t*t*c2 + t*t*t*b)
	add_child(line)