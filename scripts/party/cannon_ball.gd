class_name Cannonball
extends Area3D

@export var target: Node3D
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
	global_position += global_position.direction_to(target.global_position) * speed * delta
	global_position.y = target.global_position.y
	global_position.y += sin(global_position.distance_to(target.global_position) / starting_distance * PI) * arc_height
