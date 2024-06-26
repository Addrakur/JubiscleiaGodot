class_name PlayerWallGrab
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var gravity: float
@export var out_force: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("wall_grab")
	player.velocity.x = 0
	player.velocity.y = 1
	player.override_gravity = 1
	player.jump_count = player.max_jump_count - 1

func exit_state() -> void:
	set_physics_process(false)
	player.override_gravity = 0

func _physics_process(_delta):
	
	if player.velocity.y < gravity:
		player.velocity.y += player.velocity.y * 0.05
	
	if not player.wall_grab_ray_cast.is_colliding():
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_just_pressed("jump"):
		player.velocity.x = out_force * -player.wall_grab_ray_cast.scale.x
		player.fsm.change_state(player.jump_state)
	
	if player.is_on_floor():
		player.fsm.change_state(player.idle_state)
