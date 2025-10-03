class_name PlayerDoubleJump
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

@export var jump_height: float
@export var jump_time_to_peak: float

var jump_velocity: float
var jump_gravity: float

func _ready():
	set_physics_process(false)
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
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1_weapon != "none":
		PlayerVariables.next_skill = "1"
		player.fsm.change_state(player.jump_attack_state)
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2_weapon != "none":
		PlayerVariables.next_skill = "2"
		player.fsm.change_state(player.jump_attack_state)
