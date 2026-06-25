class_name CharacterBall
extends RigidBody3D

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
	angular_velocity.z += 0.1

func _rotate_left() -> void:
	angular_velocity.z -= 0.1
