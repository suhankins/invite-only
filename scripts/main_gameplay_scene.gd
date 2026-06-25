extends Node3D

@export var sub_viewport: SubViewport

@export var title_screen_scene: PackedScene
@export var minigame_scenes: Array[PackedScene]
var current_minigame_index: int = 0
var current_minigame_in_scene: Node

@export var fade_in: ColorRect

@export var leader_fixing_tv: TalkerSprite
@export var no_signal_card: Control

@export var fake_leader: TalkerSprite
@export var gamepad: Gamepad

func _ready() -> void:
	var tween := create_tween()
	tween.tween_property(fade_in, "color:a", 0.0, 1.0)
	await tween.finished
	await get_tree().create_timer(1.0).timeout
	await leader_fixing_tv.say_line("res://sound/leader-stupid-tv.wav", "This stupid TV never works,\nI swear to God.")
	await get_tree().create_timer(2.0).timeout
	no_signal_card.show()
	await leader_fixing_tv.say_line("res://sound/leader-tv-working.wav", "Okay, there.\nShould be working now.")
	tween = create_tween()
	tween.tween_property(leader_fixing_tv, "position:x", -5, 5.0)
	await get_tree().create_timer(2.0).timeout
	await fake_leader.say_line("res://sound/leader-bet-youve-never.wav", "Haha, bet you've never seen\nanything like this before, mate.")
	await get_tree().create_timer(2.0).timeout

	no_signal_card.hide()
	current_minigame_in_scene = title_screen_scene.instantiate()
	sub_viewport.add_child(current_minigame_in_scene)

	await get_tree().create_timer(12.5).timeout

	gamepad.show()
	await fake_leader.say_line("res://sound/leader-heres-your-controller.wav", "Here's your controller.")

	await get_tree().create_timer(3.0).timeout
	await fake_leader.say_line("res://sound/leader-minigame-explanation.wav", "Okay, all minigames are simple:\njust spin the joystick, and\noccasionally press A.\nLet's go.")
	await current_minigame_in_scene.fade_in()
	_load_current_minigame()

func _load_current_minigame() -> void:
	if current_minigame_in_scene:
		current_minigame_in_scene.queue_free()
		await get_tree().process_frame
	current_minigame_in_scene = minigame_scenes[current_minigame_index].instantiate()
	sub_viewport.add_child(current_minigame_in_scene)
	current_minigame_in_scene.restart.connect(_load_current_minigame)
	current_minigame_in_scene.next_minigame.connect(_next_minigame)

func _next_minigame() -> void:
	print("Next minigame requested but I'm lazy")
