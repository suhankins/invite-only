extends Node


var playback: AudioStreamPlaybackPolyphonic

func _ready() -> void:
    process_mode = Node.PROCESS_MODE_ALWAYS

func _enter_tree() -> void:
    # Create an audio player
    var player = AudioStreamPlayer.new()
    player.bus = "UI"
    add_child(player)

    # Create a polyphonic stream so we can play sounds directly from it
    var stream = AudioStreamPolyphonic.new()
    stream.polyphony = 32
    player.stream = stream
    player.play()
    # Get the polyphonic playback stream to play sounds
    playback = player.get_stream_playback()
