extends Label3D

func _process(_delta: float) -> void:
    _update_text()

func _update_text() -> void:
    text = "%d%%" % roundf(AudioServer.get_bus_volume_linear(0) * 100.0)
