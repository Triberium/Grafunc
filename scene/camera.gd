extends Camera2D

signal moved(new_position: Vector2)

const SPEED: float = 256.0

var last_position := self.position

func _physics_process(delta: float) -> void:
	var velocity := Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	position += delta * velocity * SPEED
	if not last_position.is_equal_approx(position):
		moved.emit(position)
		last_position = position
	
