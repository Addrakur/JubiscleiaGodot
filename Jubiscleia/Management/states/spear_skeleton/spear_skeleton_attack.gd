class_name SpearSkeletonAttack
extends State

@export var skeleton: SpearSkeleton
@export var animation: AnimationPlayer
@export var attack_timer: Timer

func _ready():
	set_physics_process(false)
	attack_timer.wait_time = Parameters.spear_skeleton_attack_cooldown

func enter_state() -> void:
	set_physics_process(true)
	skeleton.is_attacking = true
	skeleton.velocity.x = 0
	if skeleton.can_attack_player_ground:
		animation.play("attack_ground", -1, skeleton.speed)
	else:
		animation.play("attack_air", -1, skeleton.speed)

func exit_state() -> void:
	set_physics_process(false)
	skeleton.is_attacking = false
	attack_timer.start()

func _on_animation_finished(anim):
	if anim == "attack_ground" or anim == "attack_air":
		skeleton.fsm.change_state(skeleton.idle_state)
