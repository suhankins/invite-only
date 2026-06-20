class_name Bouncer
extends InteractiveArea

@export var audio_player_3d: AudioStreamPlayer3D
@export var label_3d: Label3D
@export var objects_to_disable_ray: Array[CollisionObject3D]
@export var wallet: Control
@export var seen_ticket: bool = false

func _on_click(_camera: Node) -> void:
    if not seen_ticket:
        input_ray_pickable = false
        for object in objects_to_disable_ray:
            object.input_ray_pickable = false
        await say_line("res://sound/bouncer-got-something.wav", "What, got something\nto show me?")
        wallet.show()
    else:
        say_line("res://sound/bouncer-get-in.wav", "What are you waiting for?\nGet in.")

func reenable() -> void:
    seen_ticket = true
    input_ray_pickable = true
    for object in objects_to_disable_ray:
        object.input_ray_pickable = true

func say_line(path: String, text: String) -> void:
    label_3d.text = text
    audio_player_3d.stream = load(path)
    audio_player_3d.play()
    await audio_player_3d.finished
    label_3d.text = ""
