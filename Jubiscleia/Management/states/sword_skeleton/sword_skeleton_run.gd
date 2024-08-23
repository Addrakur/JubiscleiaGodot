class_name SwordSkeletonRun
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float
@export var attack_timer: Timer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("run")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if skeleton.player_ref == null:
		skeleton.fsm.change_state(skeleton.idle_state)
	else:
		set_direction()
		skeleton.velocity.x = speed * skeleton.direction
	
	if skeleton.can_attack_player:
		if skeleton.health_component.current_poise == skeleton.health_component.max_poise and skeleton.can_protect:
			skeleton.fsm.change_state(skeleton.protect_state)
		elif attack_timer.is_stopped():
			skeleton.attack_state.attack = "run_attack"
			skeleton.fsm.change_state(skeleton.attack_state)
		else:
			skeleton.fsm.change_state(skeleton.idle_state)
	
func set_direction():
	if skeleton.player_ref.position.x > skeleton.position.x - 10:
		skeleton.direction = 1
	elif skeleton.player_ref.position.x < skeleton.position.x + 10:
		skeleton.direction = -1
