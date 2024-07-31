extends Node2D


func _draw() -> void:
	_draw_axes()


func _draw_axes() -> void:
	## Horizontal axis
	draw_line(Vector2(-320, 0), Vector2(320, 0), Color.BLACK, 1.0)
	## Vertical axis
	draw_line(Vector2(0, -320), Vector2(0, 320), Color.BLACK, 1.0)
