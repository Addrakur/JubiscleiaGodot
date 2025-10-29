extends LimboState

@export var parent: Rockrab
@export var animation: AnimationPlayer

func _enter():
	parent.velocity.x = 0
	animation.play("stun")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "stun":
		dispatch("stun_to_idle")
