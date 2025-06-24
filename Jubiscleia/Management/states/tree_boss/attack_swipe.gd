extends LimboState

@export var parent:  BossTree

var move: bool = false
@export var move_speed: float

func _enter() -> void:
	parent.velocity.x = 0
	parent.animation.play("swipe_1" if parent.fase_1 else "swipe_2", -1, parent.speed, false)

func _update(delta) -> void:
	if move:
		parent.velocity.x = move_speed * parent.direction * delta * parent.speed
	else:
		parent.velocity.x = 0

func set_move(t_or_f: bool):
	move = t_or_f

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "swipe_1" or anim_name == "swipe_2":
		dispatch("swipe_to_idle")
		parent.target = null
