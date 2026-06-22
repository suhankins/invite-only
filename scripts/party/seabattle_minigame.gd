extends Node3D

@export var ship_scene: PackedScene
@export var timer: Timer
@export var spawn_points: Array[Node3D]

func _ready() -> void:
	timer.timeout.connect(_spawn_enemy)

func _spawn_enemy() -> void:
	var point: Node3D = spawn_points.pick_random()
	var ship: EnemyBoat = ship_scene.instantiate()
	add_child(ship)
	ship.global_position = point.global_position
