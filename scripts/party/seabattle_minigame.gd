extends Node3D

signal restart()
signal next_minigame()
signal started()
signal finished()

@export var fade_screen: ColorRect
@export var start_graphic: Control
@export var finish_graphic: Control
@export var clock_container: Control
@export var music_player: AudioStreamPlayer
@export var winner_graphic: Control
@export var loser_graphic: Control

@export var ship_scene: PackedScene
@export var spawn_timer: Timer
@export var finish_timer: Timer
@export var spawn_points: Array[Node3D]

func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_enemy)
	finish_timer.timeout.connect(_finish_victory)
	start_graphic.hide()
	finish_graphic.hide()
	clock_container.hide()

	fade_screen.show()
	var tween := create_tween()
	tween.tween_property(fade_screen, "modulate:a", 0.0, 2.0)
	await tween.finished
	await get_tree().create_timer(1.5).timeout
	_start_minigame()

func _start_minigame() -> void:
	start_graphic.show()
	start_graphic.offset_transform_scale = Vector2(0.5, 0.5)
	var tween := create_tween()
	tween.tween_property(start_graphic, "offset_transform_scale", Vector2.ONE, 1.0)
	UiAudio.playback.play_stream(load("res://sound/party/announcer_start.wav"))
	await tween.finished

	start_graphic.hide()
	started.emit()
	clock_container.show()
	spawn_timer.start()
	finish_timer.start()
	music_player.play()
	_spawn_enemy()

func _finish_lose() -> void:
	await _finish_generic()
	finish_graphic.hide()

	loser_graphic.show()
	loser_graphic.offset_transform_scale = Vector2(0.5, 0.5)
	var tween := create_tween()
	tween.tween_property(loser_graphic, "offset_transform_scale", Vector2.ONE, 1.0)
	tween.tween_property(fade_screen, "modulate:a", 1.0, 2.0).set_delay(1.0)
	await tween.finished

	restart.emit()

func _finish_victory() -> void:
	await _finish_generic()
	UiAudio.playback.play_stream(load("res://sound/party/announcer_winner.wav"))
	finish_graphic.hide()
	winner_graphic.show()
	winner_graphic.offset_transform_scale = Vector2(0.5, 0.5)
	var tween := create_tween()
	tween.tween_property(winner_graphic, "offset_transform_scale", Vector2.ONE, 1.0)
	tween.tween_property(fade_screen, "modulate:a", 1.0, 2.0).set_delay(1.0)
	await tween.finished

	next_minigame.emit()

func _finish_generic() -> void:
	finished.emit()
	finish_timer.stop()
	spawn_timer.stop()
	music_player.stop()
	finish_timer.stop()
	UiAudio.playback.play_stream(load("res://sound/party/announcer_finish.wav"))
	clock_container.hide()
	finish_graphic.show()
	finish_graphic.offset_transform_scale = Vector2(0.5, 0.5)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(finish_graphic, "offset_transform_scale", Vector2.ONE, 1.0)
	await tween.finished
	await get_tree().create_timer(2.0).timeout

func _spawn_enemy() -> void:
	var point: Node3D = spawn_points.pick_random()
	var ship: EnemyBoat = ship_scene.instantiate()
	add_child(ship)
	ship.global_position = point.global_position
