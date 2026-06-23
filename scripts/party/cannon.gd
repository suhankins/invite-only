extends Node3D

@export var rotation_cap: float = 0.6
@export var cannonball_scene: PackedScene
@export var cannonball_spawn_point: Node3D
@export var cannonball_miss_target: Node3D
@export var fire_area: Area3D

var active: bool = false

func _ready() -> void:
	var root = get_tree().get_first_node_in_group("minigame_root")
	root.started.connect(start)
	root.finished.connect(stop)

func stop() -> void:
	var gamepad: Gamepad = get_tree().get_first_node_in_group("Gamepad")
	gamepad.spun_clockwise.disconnect(_rotate_right)
	gamepad.spun_counter_clockwise.disconnect(_rotate_left)
	gamepad.a_pressed.disconnect(_fire)

func start() -> void:
	var gamepad: Gamepad = get_tree().get_first_node_in_group("Gamepad")
	gamepad.spun_clockwise.connect(_rotate_right)
	gamepad.spun_counter_clockwise.connect(_rotate_left)
	gamepad.a_pressed.connect(_fire)

func _fire() -> void:
	var cannonball: Cannonball = cannonball_scene.instantiate()
	get_parent_node_3d().add_child(cannonball)
	cannonball.global_position = cannonball_spawn_point.global_position
	var target = _get_ship()
	cannonball.target = target
	if target is Node3D:
		cannonball.starting_distance = target.global_position.distance_to(global_position)
	else:
		cannonball.starting_distance = target.distance_to(global_position)

func _get_ship() -> Variant:
	var areas := fire_area.get_overlapping_areas()
	var enemy_ship_index: int = areas.find_custom(func(area): return area is EnemyBoat)
	if enemy_ship_index == -1:
		return cannonball_miss_target.global_position
	return areas[enemy_ship_index]

func _rotate_right() -> void:
	rotation.y = clampf(rotation.y - 0.01, -rotation_cap, rotation_cap)

func _rotate_left() -> void:
	rotation.y = clampf(rotation.y + 0.01, -rotation_cap, rotation_cap)
