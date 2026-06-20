extends InteractiveArea

@export var bouncer: Bouncer
@export var openable_door: OpenableDoor
@export var make_ray_pickable: Array[CollisionObject3D]

func _on_click(_camera: Node) -> void:
    if not bouncer.seen_ticket:
        bouncer.say_line("res://sound/bouncer-invite-only.wav", "This is an invite only event.\nGet lost.")
    else:
        input_ray_pickable = false
        await openable_door.open()
        for object in make_ray_pickable:
            object.input_ray_pickable = true
