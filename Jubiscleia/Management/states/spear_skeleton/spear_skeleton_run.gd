class_name SpearSkeletonRun
extends State

@export var skeleton: SpearSkeleton
@export var animation: AnimationPlayer
var speed: float
@export var attack_timer: Timer

func _ready():
	set_physics_process(false)
	speed = Parameters.spear_skeleton_run_speed

func enter_state() -> void:
	set_physics_process(true)
	animation.play("run", -1, skeleton.speed)

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if skeleton.player_ref == null:
		skeleton.fsm.change_state(skeleton.idle_state)
	else:
		set_direction()
		skeleton.velocity.x = speed * skeleton.direction
	
	if skeleton.can_attack_player_ground or skeleton.can_attack_player_air:
			if attack_timer.is_stopped():
				skeleton.fsm.change_state(skeleton.attack_state)
			else:
				skeleton.fsm.change_state(skeleton.idle_state)
	
func set_direction():
	if skeleton.player_ref.position.x > skeleton.position.x - 10:
		skeleton.direction = 1
	elif skeleton.player_ref.position.x < skeleton.position.x + 10:
		skeleton.direction = -1
