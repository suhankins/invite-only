extends Camera3D

@export var target: Node3D

func _process(delta: float) -> void:
    var target_position := target.global_position
    target_position.z = global_position.z
    global_position = MathHelper.frame_independent_lerp(global_position, target_position, 5.0, delta)
    look_at(target.global_position)
