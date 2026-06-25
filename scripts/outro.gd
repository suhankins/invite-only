extends Node3D

@export var jerma: TalkerSprite
@export var fade_in: ColorRect
@export var credits: Control

func _ready() -> void:
    fade_in.show()
    credits.hide()
    var tween := create_tween()
    tween.tween_property(fade_in, "color:a", 0.0, 2.0)
    await tween.finished
    await jerma.say_line("res://sound/jerma-0.wav", "Hey buddy. You passed out at\nyour own birthday party.")
    await get_tree().create_timer(0.5).timeout
    await jerma.say_line("res://sound/jerma-1.wav", "Geez, you kept mumbling all\nnight about some \"hib party\".")
    await get_tree().create_timer(0.5).timeout
    await jerma.say_line("res://sound/jerma-2.wav", "Come on, we need to get you\ncleaned up and everything.")
    await get_tree().create_timer(0.5).timeout
    credits.modulate.a = 0.0
    credits.show()
    tween = create_tween()
    tween.set_parallel(true)
    tween.tween_property(fade_in, "color:a", 1.0, 2.0)
    tween.tween_property(credits, "modulate:a", 1.0, 2.0)
