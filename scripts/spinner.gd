extends Node3D

@export var movement: Vector3

func _process(delta: float) -> void:
    rotation += movement * delta
