extends Control

@export var white_screen: ColorRect

func _ready() -> void:
    $AnimationPlayer.play("title_screen_animation")

func fade_in() -> void:
    var tween := create_tween()
    tween.tween_property(white_screen, "color:a", 1.0, 1.0)
    await tween.finished
