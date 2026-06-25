extends Area3D

func _ready() -> void:
    body_entered.connect(_on_body_entered)

func _on_body_entered(body) -> void:
    if body is CharacterBall:
        get_tree().get_first_node_in_group("minigame_root")._finish_victory()
