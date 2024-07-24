class_name Token extends RefCounted
## Token Class
## 
## Class for storing and defining different types of mathematical tokens such
## as numbers, operators, functions, arguments, etc.

## Enum for data types
enum Type {
	NULL, ## Invalid data type
	NUMBER, ## An integer or decimal number represented as a float
	FUNCTION, ## Mathematical function
	OPERATOR, ## Mathematical operator
	PARENTHESIS, ## Grouping order of operations
}

## Enumerator for operators
enum Operator {
	EXPONENTIATION, ## a ^ b
	MULTIPLICATION, ## a * b
	DIVISION, ## a / b
	ADDITION, ## a + b
	SUBTRACTION, ## a - b
}

enum Parenthesis {
	OPEN, ## (
	CLOSE, ## )
}

const OPERATORS = {
	&"^": Operator.EXPONENTIATION,
	&"*": Operator.MULTIPLICATION,
	&"/": Operator.DIVISION,
	&"+": Operator.ADDITION,
	&"-": Operator.SUBTRACTION,
}

const PARENTHESIS = {
	&"(": Parenthesis.OPEN,
	&")": Parenthesis.CLOSE,
}
## The value of this token
var value: Variant: get = get_value
## The type that the value shall be defined as
var type: Type

func _init(token: String = "") -> void:
	if token.is_valid_float():
		value = token.to_float()
		type = Type.NUMBER
		return
	
	if OPERATORS.has(token):
		value = StringName(token)
		type = Type.OPERATOR
		return
	
	if PARENTHESIS.has(token):
		value = StringName(token)
		type = Type.PARENTHESIS
		return


func get_value() -> Variant:
	if type == Type.NULL:
		return null
	
	if type == Type.OPERATOR or type == Type.PARENTHESIS:
		return value as StringName
	
	return value as float

## Parses an expression and returns an array of tokens
static func tokenize(string: String) -> Array[Token]:
	if string.is_empty():
		return []
	
	var tokens: Array[Token] = []
	var token := ""
	var clean := string.replace(" ", "")
	var length := clean.length()
	var end := length - 1
	for i in length:
		var character: String = clean[i]
		
		if i == 0 and i == end:
			tokens.append(Token.new(character))
			continue
		
		if i == 0:
			if character in [&"+", &"-", &"."]:
				token += character
				continue
			
			if character.is_valid_int() or character == &".":
				token += character
				continue
			
			tokens.append(Token.new(character))
			continue
		
		var previous: String = clean[i - 1]
		if i == end:
			if character.is_valid_int() or character == &".":
				token += character
				tokens.append(Token.new(token))
				continue
			
			if not token.is_empty():
				tokens.append(Token.new(token))
			
			tokens.append(Token.new(character))
			continue
		
		if character.is_valid_int() or character == &".":
			token += character
			continue
		
		if character in OPERATORS:
			if previous in [&"(", &"*", &"/", &"^"]:
				token += character
				continue
			
			if not token.is_empty():
				tokens.append(Token.new(token))
				token = ""
			
			tokens.append(Token.new(character))
			continue
		
		if character in PARENTHESIS:
			if not token.is_empty():
				tokens.append(Token.new(token))
				token = ""
			
			tokens.append(Token.new(character))
			continue
	
	return tokens

