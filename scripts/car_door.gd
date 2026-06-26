extends MoveToAreaTrigger

@export var door: Node3D

func _on_click(_camera: Node) -> void:
    super._on_click(_camera)
    input_ray_pickable = false
    var tween := get_tree().create_tween()
    tween.set_trans(Tween.TRANS_CUBIC)
    tween.tween_property(door, "rotation_degrees", Vector3(0, -67, 0), 1.0)
