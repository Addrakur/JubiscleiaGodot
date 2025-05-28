extends LimboState

@export var parent: BossTree
@export var animation: AnimationPlayer

func _enter():
	parent.health_component.invulnerable = true
	animation.play("change_fase")

func _on_animation_animation_finished(anim_name: StringName) -> void:
	if anim_name == "change_fase":
		parent.fase_1 = false
		parent.element = "fire"
		parent.health_component.invulnerable = false
		dispatch("change_fase_to_idle")
