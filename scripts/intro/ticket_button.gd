extends Button

@export var ticket_hand: Control
@export var bouncer: Bouncer

func _pressed() -> void:
	get_parent_control().hide()
	ticket_hand.show()
	await get_tree().create_timer(0.5).timeout
	await bouncer.say_line("res://sound/bouncer-go-in.wav", "Okay, go in.")
	ticket_hand.hide()
	bouncer.reenable()
