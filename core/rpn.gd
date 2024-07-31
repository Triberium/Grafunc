class_name RPN extends RefCounted
## Reverse Polish notation class
## 
## Class for storing and solving Reverse Polish notation queues. Each element
## in the queue is a Token object.

## The stored queue for solving
var queue: Array[Token]


func _operate(a: float, b: float, operator: StringName) -> float:
	var value: float = 0
	match operator:
		&"^": value = pow(a, b)
		&"*": value = a * b
		&"/": value = a / b
		&"+": value = a + b
		&"-": value = a - b
	return value


## Solves the queue and returns a number upon solving. Returns NAN if the queue was invalid.
func solve() -> float:
	var stack := queue.duplicate()
	var temp := []
	while not stack.is_empty():
		var front: Token = stack.pop_front()
		if front.type == Token.Type.NUMBER:
			temp.append(front.value)
			continue
		
		if front.type == Token.Type.OPERATOR:
			var operands := []
			while operands.size() < 2:
				var operand: Variant = temp.pop_back()
				if operand == null:
					return NAN
				operands.append(operand)
			
			temp.append(_operate(operands[1], operands[0], front.value))
			continue
	
	if temp.size() == 1:
		return temp.pop_at(0)
	
	return NAN


func get_values() -> Array[String]:
	var output: Array[String] = []
	for token: Token in queue:
		output.append(str(token.value))
	
	return output
