extends LimboState

@export var parent: LightningDash
@export var animation: AnimationPlayer

func _enter():
	parent.velocity.x = 0
	animation.play("stun")

func _update(_delta) -> void:
	pass

func _exit():
	pass

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "stun":
		dispatch("stun_to_walk")
