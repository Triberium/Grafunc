extends Node2D


func _ready() -> void:
	var tests := [
		"(1 + 1)^(4)",
		"12 / (2 ^ 2)",
		"((12.0 + 10) * 4) / (10 - (16/2))"
	]
	for test: String in tests:
		print(test)
		run_test(test)

func _draw() -> void:
	_draw_axes()

func _draw_axes() -> void:
	## Horizontal axis
	draw_line(Vector2(-320, 0), Vector2(320, 0), Color.BLACK, 1.0)
	## Vertical axis
	draw_line(Vector2(0, -320), Vector2(0, 320), Color.BLACK, 1.0)

func run_test(input: String) -> void:
	var sya := SYAlgo.new()
	sya.input = Token.tokenize(input)
	sya.parse()
	
	var queue := []
	for output: Token in sya.output.queue:
		queue.append(str(output.value))
	print("\tRPN: ", queue)
	print("\tResult: ", sya.output.solve(), "\n")
