class_name PlayerDoubleJump
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
var speed: float

var jump_height: float
var jump_time_to_peak: float

var jump_velocity: float
var jump_gravity: float

func _ready():
	set_physics_process(false)
	jump_height = Parameters.player_double_jump_height
	jump_time_to_peak = Parameters.player_double_jump_time_to_peak
	speed = Parameters.player_double_jump_move_speed
	jump_velocity = ((2.0 * jump_height) / jump_time_to_peak) * -1
	jump_gravity = ((-2.0 * jump_height) / pow(jump_time_to_peak,2)) * -1

func enter_state() -> void:
	set_physics_process(true)
	player.jump_count += 1
	animation.play("jump")
	player.velocity.y = jump_velocity
	player.override_gravity = jump_gravity

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0

func _physics_process(_delta):
	player.velocity.x = player.direction * speed
	
	if player.velocity.y > 0 or player.is_on_ceiling() or Input.is_action_just_released("jump"):
		player.fsm.change_state(player.fall_state)
	
	if player.wall_grab_ray_cast.is_colliding(): #and player.direction == player.wall_grab_ray_cast.scale.x:
		player.fsm.change_state(player.wall_grab_state)
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.jump_attack_state)
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.jump_attack_state)
