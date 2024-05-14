class_name SpearSkeletonAttack
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var attack_timer: Timer
@onready var attack_collision_air = $"../../AttackArea/AttackCollisionAir"
@onready var attack_collision_ground = $"../../AttackArea/AttackCollisionGround"

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	attack_timer.start()
	skeleton.is_attacking = true
	skeleton.velocity.x = 0
	if skeleton.can_attack_player_ground:
		animation.play("attack_ground")
	else:
		animation.play("attack_air")

func exit_state() -> void:
	set_physics_process(false)
	skeleton.is_attacking = false
	attack_collision_air.disabled = true
	attack_collision_ground.disabled = true

func _on_animation_finished(anim):
	if anim == "attack_ground" or anim == "attack_air":
		skeleton.fsm.change_state(skeleton.idle_state)
