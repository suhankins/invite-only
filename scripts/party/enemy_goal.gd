extends Area3D

func _ready() -> void:
    area_entered.connect(_on_area_entered)

func _on_area_entered(area) -> void:
    if area is EnemyBoat:
        get_tree().get_first_node_in_group("minigame_root")._finish_lose()
