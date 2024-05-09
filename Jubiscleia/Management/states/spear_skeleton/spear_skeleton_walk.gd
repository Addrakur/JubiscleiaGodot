class_name SpearSkeletonWalk
extends State

@export var skeleton: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float
@export var wander_limit: float
@export var attack_timer: Timer

var new_x: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	new_position()
	animation.play("walk")
	

func exit_state() -> void:
	set_physics_process(false)
	new_x = 0
	skeleton.direction = 0

func _physics_process(_delta):
	if new_x != 0 and skeleton.direction != 0:
		skeleton.velocity.x = skeleton.direction * speed
	
	if skeleton.position.x > new_x and skeleton.direction == 1 or skeleton.position.x < new_x and skeleton.direction == -1:
		skeleton.fsm.change_state(skeleton.idle_state)
	
	if skeleton.player_ref != null and PlayerVariables.player_alive and skeleton.player_on_limit:
		if skeleton.can_attack_player_ground or skeleton.can_attack_player_air:
			#if attack_timer.is_stopped():
			print("attack")
		else:
			skeleton.fsm.change_state(skeleton.run_state)
	

func new_position():
	new_x = randf_range(skeleton.limit.limit_polygon.polygon[0].x + wander_limit, skeleton.limit.limit_polygon.polygon[2].x + wander_limit)
	
	if skeleton.position.x > new_x:
		skeleton.direction = -1
	else:
		skeleton.direction = 1
	
