class_name PlayerJump
extends State

@export var player: Player
@export var animation: AnimationPlayer
@export var input_buffering: Timer
@onready var right_outer_ray: RayCast2D = $"../../right_outer_ray"
@onready var right_inner_ray: RayCast2D = $"../../right_inner_ray"
@onready var left_outer_ray: RayCast2D = $"../../left_outer_ray"
@onready var left_inner_ray: RayCast2D = $"../../left_inner_ray"

var speed: float

var can_move: bool = true

func _ready():
	set_physics_process(false)
	speed = Parameters.player_first_jump_move_speed

func enter_state() -> void:
	set_physics_process(true)
	can_move = true if player.direction_0.is_stopped() else false
	player.jump_count += 1
	animation.play("jump")
	player.velocity.y = player.jump_velocity
	input_buffering.stop()

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	if can_move:
		player.velocity.x = player.direction * speed
	
	if player.velocity.y > 0 or Input.is_action_just_released("jump"):
		player.fsm.change_state(player.fall_state)
	
	if right_outer_ray.is_colliding() and not right_inner_ray.is_colliding():
		player.position.x -= 5
	
	if left_outer_ray.is_colliding() and not left_inner_ray.is_colliding():
		player.position.x += 5
	
	if player.wall_grab_ray_cast.is_colliding(): #and player.direction == player.wall_grab_ray_cast.scale.x:
		player.fsm.change_state(player.wall_grab_state)
	
	if player.velocity.x > 0 and Input.is_action_just_pressed("left") or player.velocity.x < 0 and Input.is_action_just_pressed("right"):
		can_move = true
	
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.jump_attack_state)
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.jump_attack_state)

func _on_direction_0_timeout():
	pass
	if player.direction != 0:
		can_move = true
