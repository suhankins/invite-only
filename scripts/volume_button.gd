extends InteractiveArea

@export var value: float = 0.1

func _on_click(_camera: Node) -> void:
    UiAudio.playback.play_stream(load("res://sound/gamepad_click.wav"))
    AudioServer.set_bus_volume_linear(0, clampf(AudioServer.get_bus_volume_linear(0) + value, 0.0, 1.0))
