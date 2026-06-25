class_name ShakyCamera
extends Camera3D

@export var bobbing_curve: Curve
@export var bobbing_cycle: float = 4.0
@export var bobbing_amplitude: float = 0.00005
var bobbing_timer: float = 0.0

func _process(delta: float) -> void:
    bobbing_timer += delta
    if bobbing_timer > bobbing_cycle:
        bobbing_timer = 0.0
    var cycle_pos := bobbing_curve.sample_baked(bobbing_timer / bobbing_cycle)
    global_position.y += cycle_pos * bobbing_amplitude
