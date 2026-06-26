extends InteractiveArea

@export var audio_player: AudioStreamPlayer3D

func _on_click(_camera: Node) -> void:
    if audio_player.stream_paused:
        audio_player.stream_paused = not audio_player.stream_paused
    elif not audio_player.playing:
        audio_player.play()
    else:
        audio_player.stream_paused = not audio_player.stream_paused
