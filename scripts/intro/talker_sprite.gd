class_name TalkerSprite
extends Sprite3D

@export var audio_player_3d: AudioStreamPlayer3D
@export var label_3d: Label3D

func say_line(path: String, text: String) -> void:
    label_3d.text = text
    audio_player_3d.stream = load(path)
    audio_player_3d.play()
    await audio_player_3d.finished
    label_3d.text = ""
