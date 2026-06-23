extends Area3D

@export var respawn_point: Node3D
@export var restart_platform: Node3D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
	body.global_position = respawn_point.global_position
	if restart_platform:
		restart_platform.reset()
