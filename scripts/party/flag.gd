extends Node3D

@export var minimum_height: float = 6.4
@export var maximum_height: float = 176.0
@export var rate: float = 0.05

func _ready() -> void:
	var root = get_tree().get_first_node_in_group("minigame_root")
	root.started.connect(start)
	root.finished.connect(stop)

func stop() -> void:
	var gamepad: Gamepad = get_tree().get_first_node_in_group("Gamepad")
	gamepad.spun_clockwise.disconnect(_rotate_right)
	gamepad.spun_counter_clockwise.disconnect(_rotate_left)

func start() -> void:
	var gamepad: Gamepad = get_tree().get_first_node_in_group("Gamepad")
	gamepad.spun_clockwise.connect(_rotate_right)
	gamepad.spun_counter_clockwise.connect(_rotate_left)

func _rotate_right() -> void:
	position.y = clampf(position.y + rate, minimum_height, maximum_height)
	if is_equal_approx(position.y, maximum_height):
		get_tree().get_first_node_in_group("minigame_root")._finish_victory()

func _rotate_left() -> void:
	position.y = clampf(position.y - rate, minimum_height, maximum_height)
