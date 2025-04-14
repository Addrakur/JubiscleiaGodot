class_name PlayerHeal
extends State

@export var parent: Player
@export var animation: AnimationPlayer
@export var element_manager: ElementManager

var anim_finish: bool = false

func enter_state():
	anim_finish = false
	animation.play(PlayerVariables.elemental_rupture + "_healing")
	element_manager.element_timer.stop()

func _physics_process(_delta: float) -> void:
	pass

func exit_state():
	if anim_finish:
		element_manager.end_rupture()
	else:
		animation.play(PlayerVariables.elemental_rupture)
		element_manager.element_timer.start()

func _on_aura_animations_animation_finished(anim_name: StringName) -> void:
	if anim_name == PlayerVariables.elemental_rupture + "_healing":
		anim_finish = true
