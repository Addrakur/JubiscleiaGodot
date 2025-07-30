extends LimboState

@export var parent: Stalac
@export var animation: AnimationPlayer
@export var fall_1: RayCast2D
@export var fall_2: RayCast2D

func _enter():
	pass

func _exit():
	pass

func _update(_delta) -> void:
	if not parent.player_on_limit:
		return
	if parent.rotation != 0:
		if fall_1.is_colliding() or fall_2.is_colliding():
			animation.play("idle_out")

func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "idle_out":
		if parent.is_on_floor():
			dispatch("inactive_to_idle")
		else:
			dispatch("inactive_to_fall_attack")

func _on_activate_area_body_entered(body: Node2D) -> void:
	if parent.rotation == 0 and parent.hsm.get_active_state() == parent.inactive_state:
		animation.play("idle_out")
