extends Node3D

@export var fade_screen: ColorRect
@export var start_graphic: Control
@export var finish_graphic: Control
@export var clock_container: Control
@export var music_player: AudioStreamPlayer

@export var ship_scene: PackedScene
@export var spawn_timer: Timer
@export var finish_timer: Timer
@export var spawn_points: Array[Node3D]

func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_enemy)
	start_graphic.hide()
	finish_graphic.hide()
	clock_container.hide()

	fade_screen.show()
	var tween := create_tween()
	tween.tween_property(fade_screen, "modulate:a", 0.0, 2.0)
	await get_tree().create_timer(2.0).timeout
	_start_minigame()

func _start_minigame() -> void:
	start_graphic.show()
	start_graphic.offset_transform_scale = Vector2(0.5, 0.5)
	var tween := create_tween()
	tween.set_trans(Tween.TRANS_BOUNCE)
	tween.tween_property(start_graphic, "offset_transform_scale", Vector2.ONE, 1.0)
	UiAudio.playback.play_stream(load("res://sound/party/announcer_start.wav"))
	await tween.finished
	start_graphic.hide()

	clock_container.show()
	spawn_timer.start()
	finish_timer.start()
	music_player.play()

func _spawn_enemy() -> void:
	var point: Node3D = spawn_points.pick_random()
	var ship: EnemyBoat = ship_scene.instantiate()
	add_child(ship)
	ship.global_position = point.global_position
