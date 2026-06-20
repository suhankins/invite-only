extends MoveToAreaTrigger

@export var card_giver: TalkerSprite
@export var you_bet_guy: TalkerSprite
@export var leader: TalkerSprite
@export var cards_to_flip_0: PairOfCards
@export var cards_to_flip_1: PairOfCards

func _on_click(camera: Node) -> void:
    await super._on_click(camera)
    await get_tree().create_timer(1.0).timeout
    await card_giver.say_line("res://sound/poker-player-next-game.wav", "So, everyone ready\nfor another game?")
    await you_bet_guy.say_line("res://sound/poker-player-you-bet.wav", "You bet.")
    await get_tree().create_timer(1.0).timeout
    cards_to_flip_0.flip()
    await get_tree().create_timer(1.0).timeout
    cards_to_flip_1.flip()
    await get_tree().create_timer(0.7).timeout
    await leader.say_line("res://sound/leader-wait-dont-give-him-cards.wav", "Wait...\nDon't give them cards.")
    await get_tree().create_timer(0.5).timeout
    await leader.say_line("res://sound/leader-hey-new-blood.wav", "Hey new blood.\nDo you want to have some real fun?")
