extends Label

@export var timer: Timer

func _process(delta: float) -> void:
	text = "%d" % timer.time_left
