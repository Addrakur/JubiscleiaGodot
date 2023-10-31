class_name PlayerMove
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.jump_count = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.direction = Input.get_axis("left","right")
	animation.play("run")
	player.velocity.x = player.direction * speed
	
	if player.direction == 0:
		player.fsm.change_state(player.idle_state)
	
	if Input.is_action_pressed("jump"):
		player.jump_count += 1
		player.fsm.change_state(player.jump_state)
	
	if player.velocity.y > 0:
		player.jump_count += 1
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_pressed("look_down"):
		player.fsm.change_state(player.crouch_state)
	
	if Input.is_action_just_pressed("Basic_Attack"):
		player.fsm.change_state(player.sword_attack_1_state)
