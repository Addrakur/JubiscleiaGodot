class_name PlayerIdle
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("idle")
	if player.is_on_floor():
		player.jump_count = 0
	player.velocity.x = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	
	if player.direction != 0 && player.is_on_floor():
		player.fsm.change_state(player.move_state)
	
	if Input.is_action_pressed("jump") and player.jump_count < player.max_jump_count:
		player.fsm.change_state(player.jump_state)
	
	if player.velocity.y > 0:
		player.jump_count += 1
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_pressed("crouch"):
		player.fsm.change_state(player.crouch_state)
	
	if Input.is_action_just_pressed("attack_button_1"):
		PlayerVariables.current_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.attack_1_state)
	
	if Input.is_action_just_pressed("attack_button_2"):
		PlayerVariables.current_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.attack_1_state)

