extends CanvasLayer

enum ID {
	ABOUT,
}

const ui := {
	ID.ABOUT: preload("res://gui/about.tscn"),
}

@onready var Base: PackedScene = preload("res://gui/base.tscn")

func _ready() -> void:
	_setup_base()


func _setup_base() -> void:
	var base: Control = Base.instantiate()
	add_child(base)
	base.version.text = ProjectSettings.get_setting("application/config/version")

func display(id: ID) -> void:
	var canvas: CanvasLayer = ui[id].instantiate()
	add_child(canvas)
