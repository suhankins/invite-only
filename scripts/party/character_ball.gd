extends RigidBody3D

func _ready() -> void:
	var gamepad: Gamepad = get_tree().get_first_node_in_group("Gamepad")
	gamepad.spun_clockwise.connect(_rotate_right)
	gamepad.spun_counter_clockwise.connect(_rotate_left)

func _rotate_right() -> void:
	angular_velocity.z += 0.1

func _rotate_left() -> void:
	angular_velocity.z -= 0.1
