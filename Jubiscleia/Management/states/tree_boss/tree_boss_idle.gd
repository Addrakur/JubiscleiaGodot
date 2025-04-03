extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer

func _enter() -> void:
	animation.play("idle")

func _update(_delta: float):
	if parent.player_on_limit:
		dispatch("idle_to_move")
