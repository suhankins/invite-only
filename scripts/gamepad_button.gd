extends Button

func _pressed() -> void:
    UiAudio.playback.play_stream(load("res://sound/gamepad_click.wav"))
