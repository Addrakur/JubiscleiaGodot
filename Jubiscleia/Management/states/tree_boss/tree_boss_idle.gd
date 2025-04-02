extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer

func _enter() -> void:
	animation.play("idle")
