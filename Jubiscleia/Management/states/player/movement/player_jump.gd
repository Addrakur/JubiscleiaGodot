class_name PlayerJump
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
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

func exit_state() -> void:
	set_physics_process(false)
	can_move = true

func _physics_process(_delta):
	if can_move:
		player.velocity.x = player.direction * speed
	
	if player.velocity.y > 0 or player.is_on_ceiling() or Input.is_action_just_released("jump"):
		player.fsm.change_state(player.fall_state)
	
	if player.velocity.x > 0 and Input.is_action_just_pressed("left") or player.velocity.x < 0 and Input.is_action_just_pressed("right"):
		can_move = true
	
	#if Input.is_action_just_pressed("jump") and player.jump_count < player.max_jump_count:
	#	player.fsm.change_state(player.double_jump_state)
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack:
		PlayerVariables.current_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.jump_attack_state)
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack:
		PlayerVariables.current_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.jump_attack_state)

func _on_direction_0_timeout():
	pass
	#player.fsm.change_state(player.fall_state)
	can_move = true
