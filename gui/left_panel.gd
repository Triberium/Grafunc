extends HBoxContainer

const InputControl: PackedScene = preload("res://gui/input_control.tscn")

@onready var list: PanelContainer = $List
@onready var inputs: VBoxContainer = $List/Scroll/Container/Inputs
@onready var label: Label = $Expander/Label


func _ready() -> void:
	_add_input_control()


func _on_expander_gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton
	and event.button_index == MOUSE_BUTTON_LEFT
	and event.pressed == true):
		list.visible = not list.visible
		if list.visible:
			label.text = "<"
		else:
			label.text = ">"


func _on_add_pressed() -> void:
	_add_input_control()


func _add_input_control() -> void:
	var input_control := InputControl.instantiate()
	inputs.add_child(input_control)
	input_control.deleted.connect(_input_control_deleted)


func _input_control_deleted(node: PanelContainer) -> void:
	if inputs.get_child_count() <= 1:
		_add_input_control()
	
	node.queue_free()
	
