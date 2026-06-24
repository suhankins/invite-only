class_name Gamepad
extends Control

@export var joystick: Joystick
@export var a_button: Button

signal a_pressed()
signal spun_counter_clockwise()
signal spun_clockwise()

func _ready() -> void:
	joystick.spun_counter_clockwise.connect(spun_counter_clockwise.emit)
	joystick.spun_clockwise.connect(spun_clockwise.emit)
	a_button.pressed.connect(a_pressed.emit)
