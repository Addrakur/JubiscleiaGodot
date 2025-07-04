class_name PlayerWallGrab
extends State

@export var player: Player
@export var animation: AnimationPlayer
@export var gravity: float
@export var out_force: float
@export var wait_time_min: float
@export var wait_time_max: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("wall_grab")
	player.velocity.x = 0
	player.velocity.y = 1# if player.velocity.y > 0 else player.velocity.y
	player.override_gravity = 1
	player.jump_count = player.max_jump_count - 1
	player.can_dash = true

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0

func _physics_process(delta):
	
	if player.velocity.y < gravity:
		player.velocity.y += player.velocity.y * delta * 10
	
	if not player.wall_grab_ray_cast.is_colliding():
		player.fsm.change_state(player.fall_state)
		player.jump_count = player.max_jump_count
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.x = out_force * -player.wall_grab_ray_cast.scale.x
		player.last_direction = -player.wall_grab_ray_cast.scale.x
		player.direction_0.wait_time = wait_time_min if player.direction != 0 else wait_time_max
		player.direction_0.start()
		player.wall_grab_ray_cast.scale.x *= -1
		player.fsm.change_state(player.jump_state)
	
	if player.is_on_floor():
		player.fsm.change_state(player.idle_state)
