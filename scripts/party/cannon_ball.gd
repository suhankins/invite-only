class_name Cannonball
extends Area3D

@export var target: Variant
@export var speed: float = 5.0
@export var starting_distance: float = 0.0
@export var arc_height: float = 5.0

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area3D) -> void:
	if area is EnemyBoat:
		area.die()
		queue_free()

func _process(delta: float) -> void:
	if not is_instance_valid(target) and not target is Vector3:
		queue_free()
		return
	var target_position: Vector3
	if target is Node3D:
		target_position = target.global_position
	elif target is Vector3:
		target_position = target
	global_position += global_position.direction_to(target_position) * speed * delta
	global_position.y = target_position.y
	global_position.y += sin(global_position.distance_to(target_position) / starting_distance * PI) * arc_height
	if global_position.y < 0.0:
		queue_free()
