class_name PlayerJump
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("jump")
	player.velocity.y = player.jump_velocity

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.direction = Input.get_axis("left","right")
	player.velocity.x = player.direction * speed
	
	if player.velocity.y < 0 or player.is_on_ceiling():
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_just_pressed("jump") and player.jump_count < player.max_jump_count:
		player.jump_count += 1
		player.fsm.change_state(player.double_jump_state)
	
