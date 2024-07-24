extends CanvasLayer

@onready var name_version: Label = $Window/VBox/Header/Info/NameVersion
@onready var license_label: Label = $Window/VBox/Tabs/License/Content
@onready var third_party_label: Label = $"Window/VBox/Tabs/3rd Party Licenses/Data/Content"


func _ready() -> void:
	var license_file: FileAccess = FileAccess.open("res://gui/text/LICENSE.txt", FileAccess.READ)
	license_label.text = license_file.get_as_text()
	name_version.text = "Grafunc v" + ProjectSettings.get_setting("application/config/version")


func _on_close_pressed() -> void:
	queue_free()


func _on_options_item_selected(index: int) -> void:
	match index:
		0:
			var license_file: FileAccess = FileAccess.open("res://thirdparty/font/LICENSE.Jost.txt", FileAccess.READ)
			third_party_label.text = license_file.get_as_text()
