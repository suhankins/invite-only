class_name PairOfCards
extends Node3D

func _ready() -> void:
    visible = false

func flip() -> void:
    $AudioStreamPlayer3D.play()
    show()
