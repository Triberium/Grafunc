class_name SYAlgo extends RefCounted
## Shunting Yard Algorithm Class
##
## Class for parsing arithmetical and/or logical expressions using
## the Shunting Yard Algorithm

## Associativity enum
enum Associativity {
	LEFT,
	RIGHT
}

## Precedence of operators
const PRECEDENCE := {
	Token.Operator.EXPONENTIATION: 4,
	Token.Operator.MULTIPLICATION: 3,
	Token.Operator.DIVISION: 3,
	Token.Operator.ADDITION: 2,
	Token.Operator.SUBTRACTION: 2,
}

## Associativity of operators
const ASSOCIATIVITY := {
	Token.Operator.EXPONENTIATION: Associativity.RIGHT,
	Token.Operator.MULTIPLICATION: Associativity.LEFT,
	Token.Operator.DIVISION: Associativity.LEFT,
	Token.Operator.ADDITION: Associativity.LEFT,
	Token.Operator.SUBTRACTION: Associativity.LEFT,
}

## The operator stack
var _operators: Array[Token]

## The input to be parsed by this class
var input: Array[Token]

## The output as an RPN object
var output: RPN

## Parses the input returning an Error if there were issues encountered.
func parse() -> void:
	_operators.clear()
	output = RPN.new()
	var copy := input.duplicate()
	
	var a := []
	for b: Token in copy:
		a.append(str(b.value))
	#print("Stack: ", a)
	
	while not copy.is_empty():
		var token: Token = copy.pop_front()
		if token.type == Token.Type.NUMBER:
			_push_queue(token)
			continue
		
		# TODO
		if token.type == Token.Type.FUNCTION:
			_push_operator(token)
			continue
		
		if token.type == Token.Type.OPERATOR:
			while not _operators.is_empty():
				var previous_operator: Token = _operators.back()
				if previous_operator.value == &"(":
					break
				
				var this_precedence: int = _get_precedence(token)
				var this_associative: Associativity = _get_associativity(token)
				var previous_precedence: int = _get_precedence(previous_operator)
				if (previous_precedence > this_precedence or 
				(previous_precedence == this_precedence and 
				this_associative == Associativity.LEFT)):
					_push_queue(_operators.pop_back())
					continue
				
				break
			
			_push_operator(token)
			continue
		
		if token.value == &"(":
			_push_operator(token)
			continue
		
		if token.value == &")":
			while not _operators.is_empty():
				var previous_operator: Token = _operators.pop_back()
				if previous_operator.value == &"(":
					break
				
				_push_queue(previous_operator)
				
			continue
		
	
	while not _operators.is_empty():
		_push_queue(_operators.pop_back())

func _push_operator(token: Token) -> void:
	_operators.append(token)


func _push_queue(token: Token) -> void:
	output.queue.append(token)


func _get_precedence(token: Token) -> int:
	return PRECEDENCE[Token.OPERATORS[token.value]]


func _get_associativity(token: Token) -> Associativity:
	return ASSOCIATIVITY[Token.OPERATORS[token.value]]
