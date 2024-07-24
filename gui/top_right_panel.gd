extends PanelContainer

@onready var menu: MenuButton = $Menu


func _ready() -> void:
	var popup := menu.get_popup()
	popup.transparent_bg = true
	popup.id_pressed.connect(_on_id_pressed)


func _on_id_pressed(id: int) -> void:
	match id:
		0:
			GUI.display(GUI.ID.ABOUT)
		1:
			OS.shell_open("https://github.com/Triberium/Grafunc")
