class_name PlayerDoubleJump
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.jump_count += 1
	animation.play("jump")
	player.velocity.y = player.jump_velocity

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.direction = Input.get_axis("left","right")
	player.velocity.x = player.direction * speed
	
	if player.velocity.y < 0 or player.is_on_ceiling():
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_just_pressed("attack_button_1"):
		PlayerVariables.current_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.jump_attack_state)
	
	if Input.is_action_just_pressed("attack_button_2"):
		PlayerVariables.current_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.jump_attack_state)
