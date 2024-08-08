extends Node2D

const SPACING: float = 32.0

var camera_position: Vector2 = Vector2.ZERO
var hidden_margin: float = SPACING * 4.0

func _ready() -> void:
	get_viewport().size_changed.connect(_viewport_size_changed)


func _viewport_size_changed() -> void:
	queue_redraw()


func _camera_moved(new_position: Vector2) -> void:
	camera_position = new_position
	queue_redraw()


func _draw() -> void:
	_draw_grid()
	_draw_axes()


func _draw_grid() -> void:
	var rect := get_viewport_rect().size
	var verticals := floori(rect.x / SPACING) + 1
	var horizontals := floori(rect.y / SPACING) + 1
	var half := _get_half_viewport()
	var margins := _get_margins()
	var min_size := camera_position - half
	#var max_size := camera_position + half
	## Vertical lines
	for vertical: int in verticals:
		var adjusted_x := snappedf(min_size.x + (float(vertical) * SPACING), SPACING)
		if is_zero_approx(adjusted_x):
			continue
		
		draw_line(Vector2(adjusted_x, camera_position.y - margins.y), Vector2(adjusted_x, camera_position.y + margins.y), Color.WEB_GRAY, -1.0)
	
	for horizontal: int in horizontals:
		var adjusted_y := snappedf(min_size.y + (float(horizontal) * SPACING), SPACING)
		if is_zero_approx(adjusted_y):
			continue
		
		draw_line(Vector2(camera_position.x - margins.x, adjusted_y), Vector2(camera_position.x + margins.x, adjusted_y), Color.WEB_GRAY, -1.0)


func _draw_axes() -> void:
	var margins := _get_margins()
	## Horizontal axis
	if (camera_position.x < margins.x or
		camera_position.x > -margins.x):
		draw_line(Vector2(-margins.x + camera_position.x, 0), Vector2(margins.x + camera_position.x, 0), Color.BLACK, 2.0)
	
	## Vertical axis
	if (camera_position.y < margins.y or
		camera_position.y > -margins.y):
		draw_line(Vector2(0, -margins.y + camera_position.y), Vector2(0, margins.y + camera_position.y), Color.BLACK, 2.0)


func _get_half_viewport() -> Vector2:
	var rect := get_viewport_rect()
	var half: Vector2 = rect.size/2.0
	return half


func _get_margins() -> Vector2:
	var half := _get_half_viewport()
	var margins: Vector2 = half + Vector2(hidden_margin, hidden_margin)
	return margins
