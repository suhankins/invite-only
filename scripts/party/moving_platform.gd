extends StaticBody3D

@export var start: Node3D
@export var end: Node3D

var tween: Tween

func _ready() -> void:
	start_tween()

func reset() -> void:
	tween.kill()
	global_position = start.global_position
	start_tween()

func start_tween() -> void:
	tween = create_tween()
	tween.tween_property(self, "global_position", end.global_position, 5.0).set_delay(4)
	tween.tween_property(self, "global_position", start.global_position, 5.0).set_delay(4)
	tween.set_loops(99999)
