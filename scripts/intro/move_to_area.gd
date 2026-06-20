class_name MoveToAreaTrigger
extends InteractiveArea

@export var target: Node3D
@export var make_ray_pickable: Array[CollisionObject3D]

func _on_click(camera: Node) -> void:
	input_ray_pickable = false
	var tween := create_tween()
	tween.tween_property(camera, "global_transform", target.global_transform, 1.0)
	await tween.finished
	for object in make_ray_pickable:
		object.input_ray_pickable = true
