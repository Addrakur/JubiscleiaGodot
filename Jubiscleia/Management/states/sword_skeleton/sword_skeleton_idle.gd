class_name SwordSkeletonIdle
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
		if skeleton.can_attack_player:
			if skeleton.health_component.current_poise == skeleton.health_component.max_poise and skeleton.can_protect:
				skeleton.fsm.change_state(skeleton.protect_state)
			elif attack_timer.is_stopped():
				print(str(skeleton.health_component.current_poise) + str(skeleton.can_protect))
				skeleton.attack_state.attack = "attack_1"
				skeleton.fsm.change_state(skeleton.attack_state)
		else:
			skeleton.fsm.change_state(skeleton.run_state)
	else:
		if idle_timer.is_stopped():
			skeleton.fsm.change_state(skeleton.walk_state)
