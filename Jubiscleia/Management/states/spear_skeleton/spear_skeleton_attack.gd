class_name SpearSkeletonAttack
extends State

@export var poise_damage: float
@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var attack_timer: Timer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	skeleton.is_attacking = true
	skeleton.velocity.x = 0
	if skeleton.can_attack_player_ground:
		animation.play("attack_ground")
	else:
		animation.play("attack_air")

func exit_state() -> void:
	set_physics_process(false)
	skeleton.is_attacking = false

func _on_animation_finished(anim):
	if anim == "attack_ground" or anim == "attack_air":
		skeleton.fsm.change_state(skeleton.idle_state)

func attack_timer_start():
	attack_timer.start()
