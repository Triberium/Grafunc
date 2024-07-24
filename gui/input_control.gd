extends PanelContainer

signal deleted(node: PanelContainer)

@onready var line_edit: LineEdit = $Horizontal/LineEdit
@onready var equal: Label = $Horizontal/Equal
@onready var options: MenuButton = $Horizontal/Options

var expression_format := "= %s"

func _ready() -> void:
	var popup := options.get_popup()
	popup.transparent_bg = true
	popup.id_pressed.connect(_on_id_pressed)


func _on_line_edit_text_changed(new_text: String) -> void:
	var sya := SYAlgo.new()
	sya.input = Token.tokenize(new_text)
	sya.parse()
	var output := sya.output.solve()
	var output_string := ""
	if is_nan(output) or sya.output.queue.size() < 2:
		equal.hide()
		return
	
	equal.show()
	if output > 999999999999:
		output_string = String.num_scientific(output)
	else:
		output_string = str(output)
	equal.text = expression_format % str(output_string)


func _on_id_pressed(id: int) -> void:
	match id:
		0: #Delete
			deleted.emit(self)
