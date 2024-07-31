extends CanvasLayer

enum ID {
	ABOUT,
}

const ui := {
	ID.ABOUT: preload("res://gui/about.tscn"),
}

func _ready() -> void:
	_setup_base()


func _setup_base() -> void:
	var top_right_panel := preload("res://gui/top_right_panel.tscn").instantiate()
	var left_panel := preload("res://gui/left_panel.tscn").instantiate()
	var version := preload("res://gui/version.tscn").instantiate()
	add_child(top_right_panel)
	add_child(left_panel)
	add_child(version)
	version.text = ProjectSettings.get_setting("application/config/version")


func display(id: ID) -> void:
	var canvas: CanvasLayer = ui[id].instantiate()
	add_child(canvas)
