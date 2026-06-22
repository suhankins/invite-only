class_name Joystick
extends TextureRect

@export var max_distance: float = 15.0
@export var required_angle_per_second: float = PI * 2
var joystick_position: Vector2
var last_joystick_angle: float

signal spun_counter_clockwise()
signal spun_clockwise()

var dragging: bool = false
var mouse_inside: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(delta: float) -> void:
	if dragging:
		var center := get_parent_control().global_position
		var mouse_position := get_viewport().get_mouse_position()
		var offset_position := mouse_position - center - size / 2.0
		var offset_direction := offset_position.normalized()
		var offset_distance := offset_position.length()

		offset_transform_position = offset_direction * clamp(offset_distance, -max_distance, max_distance)
		joystick_position = offset_direction * (clamp(offset_distance, -max_distance, max_distance) / max_distance)
		var joystick_angle := joystick_position.angle()
		var difference := angle_difference(joystick_angle, last_joystick_angle)
		last_joystick_angle = joystick_angle
		# Probably a bad idea but good enough by me
		if difference > required_angle_per_second * delta:
			spun_counter_clockwise.emit()
		if difference < -required_angle_per_second * delta:
			spun_clockwise.emit()
	else:
		offset_transform_position = Vector2.ZERO
		joystick_position = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if (event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT):
		if (event.pressed and mouse_inside and not dragging):
			dragging = true
		if (not event.pressed and dragging):
			dragging = false

func _on_mouse_entered() -> void:
	mouse_inside = true

func _on_mouse_exited() -> void:
	mouse_inside = false
