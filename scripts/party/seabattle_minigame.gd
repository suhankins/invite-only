extends Minigame

@export var clock_container: Control

@export var ship_scene: PackedScene
@export var spawn_timer: Timer
@export var finish_timer: Timer
@export var spawn_points: Array[Node3D]

func _ready() -> void:
	spawn_timer.timeout.connect(_spawn_enemy)
	finish_timer.timeout.connect(_finish_victory)
	clock_container.hide()
	super._ready()

func _start_minigame() -> void:
	await super._start_minigame()
	clock_container.show()
	spawn_timer.start()
	finish_timer.start()
	_spawn_enemy()

func _finish_generic() -> void:
	spawn_timer.stop()
	clock_container.hide()
	await super._finish_generic()

func _spawn_enemy() -> void:
	var point: Node3D = spawn_points.pick_random()
	var ship: EnemyBoat = ship_scene.instantiate()
	add_child(ship)
	ship.global_position = point.global_position
