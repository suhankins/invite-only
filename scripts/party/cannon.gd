extends Node3D

func _ready() -> void:
	get_tree().get_first_node_in_group("joystick").spun_clockwise.connect(_rotate_right)
	get_tree().get_first_node_in_group("joystick").spun_counter_clockwise.connect(_rotate_left)

func _rotate_right() -> void:
	rotation.y -= 0.01

func _rotate_left() -> void:
	rotation.y += 0.01
