extends Node3D

@export var minimum_height: float = 6.4
@export var maximum_height: float = 176.0
@export var rate: float = 0.05

func _ready() -> void:
	var gamepad: Gamepad = get_tree().get_first_node_in_group("Gamepad")
	gamepad.spun_clockwise.connect(_rotate_right)
	gamepad.spun_counter_clockwise.connect(_rotate_left)

func _rotate_right() -> void:
	position.y = clampf(position.y + rate, minimum_height, maximum_height)

func _rotate_left() -> void:
	position.y = clampf(position.y - rate, minimum_height, maximum_height)
