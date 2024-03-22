class_name SpearSkeletonIdle
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var idle_timer: Timer
@export var attack_timer: Timer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	idle_timer.start()
	set_physics_process(true)
	animation.play("idle")
	skeleton.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	
	if skeleton.player_ref != null and PlayerVariables.player_alive and skeleton.player_on_limit:
		if skeleton.can_attack_player_ground or skeleton.can_attack_player_air:
			if attack_timer.is_stopped():
				skeleton.fsm.change_state(skeleton.attack_state)
		else:
			skeleton.fsm.change_state(skeleton.run_state)
	else:
		if idle_timer.is_stopped():
			skeleton.fsm.change_state(skeleton.walk_state)
