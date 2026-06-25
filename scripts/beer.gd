class_name Beer
extends InteractiveArea

@export var animation_player: AnimationPlayer
@export var gamepad: Control

signal interaction_finished()

func _on_click(_camera: Node) -> void:
	gamepad.hide()
	animation_player.play("drinking")
	input_ray_pickable = false
	await animation_player.animation_finished
	interaction_finished.emit()
