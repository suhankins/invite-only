class_name EnemyBoat
extends Area3D

@export var speed: float = 2.0
@export var sinking_speed: float = 2.0
@export var explosion_sprite: Node3D
var goal_position: Vector3
var alive: bool = true

func _ready() -> void:
	goal_position = get_tree().get_first_node_in_group("enemy_goal").global_position

func _process(delta: float) -> void:
	if alive:
		look_at(goal_position)
		global_position += global_position.direction_to(goal_position) * speed * delta
	else:
		global_position.y -= sinking_speed * delta
		rotation.z += 0.1 * delta
		if global_position.y < -5.0:
			queue_free()

func die() -> void:
	explosion_sprite.show()
	alive = false
