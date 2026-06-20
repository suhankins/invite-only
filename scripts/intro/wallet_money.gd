extends Button

@export var bouncer: Bouncer

func _pressed() -> void:
	bouncer.say_line("res://sound/bouncer-cant-afford.wav", "You can't afford\nto bribe me, son.")
