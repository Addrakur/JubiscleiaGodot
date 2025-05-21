extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer
@export var tree: BTPlayer
@export var change_fase_life_threshold: float

func _enter():
	if parent.health_component.current_health < parent.health_component.max_health * change_fase_life_threshold and parent.fase_1:
		dispatch("idle_to_change_fase")
		return
	tree.active = true
	if parent.fase_1:
		animation.play("idle_1")
	else:
		animation.play("idle_2")

func _exit():
	tree.active = false
