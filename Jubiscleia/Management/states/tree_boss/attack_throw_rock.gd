extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer

func _enter() -> void:
	parent.velocity.x = 0
	if parent.target == null:
		set_target()
	if parent.can_attack_ranged:
		if parent.target == parent.arena_right:
			parent.left()
		else:
			parent.right()
		animation.play("rock_throw" if parent.fase_1 else "fire_throw")
	else:
		dispatch("throw_to_run")

func set_target():
	if parent.player_ref.position.x > parent.position.x:
		parent.target = parent.arena_left
	else:
		parent.target = parent.arena_right
	print(parent.target)

func _exit() -> void:
	if parent.can_attack_ranged:
		parent.target = null

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "rock_throw" or anim_name == "fire_throw":
		dispatch("throw_to_idle")
		parent.target = null
