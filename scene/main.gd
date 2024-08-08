extends Node2D

@onready var grid: Node2D = preload("res://scene/grid.gd").new()
@onready var drawings: CanvasGroup = CanvasGroup.new()
@onready var camera: Camera2D = preload("res://scene/camera.gd").new()


func _ready() -> void:
	
	get_viewport().size_changed.connect(_viewport_size_changed)
	_setup_base()
	run_tests()


func _viewport_size_changed() -> void:
	pass

func run_tests() -> void:
	var tests := [
		"(1 + 1)^(4)",
		"12 / (2 ^ 2)",
		"((12.0 + 10) * 4) / (10 - (16/2))"
	]
	for test: String in tests:
		var sya := SYAlgo.new()
		sya.input = Token.tokenize(test)
		sya.parse()
		print(test)
		print("\tRPN: ", sya.output.get_values())
		print("\tResult: ", sya.output.solve(), "\n")


func _setup_base() -> void:
	grid.name = "Grid"
	add_child(grid)
	drawings.name = "Drawings"
	add_child(drawings)
	camera.name = "Camera"
	add_child(camera)
	camera.moved.connect(grid._camera_moved)
	
