class_name OpenableDoor
extends Node3D

func open() -> void:
    $AudioStreamPlayer3D.play()
    var tween := get_tree().create_tween()
    tween.set_trans(Tween.TRANS_CUBIC)
    tween.tween_property($doorway_1/door_4, "rotation_degrees", Vector3(0, -110, 0), 1.0)
    await tween.finished
