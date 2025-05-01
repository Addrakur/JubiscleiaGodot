class_name PlayerMove
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
var speed: float

func _ready():
	set_physics_process(false)
	speed = Parameters.player_run_speed

func enter_state() -> void:
	set_physics_process(true)
	player.jump_count = 0

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	animation.play("run")
	player.velocity.x = player.direction * speed
	
	if player.direction == 0:
		player.fsm.change_state(player.idle_state)
	
	if Input.is_action_just_pressed("jump") or not player.fall_state.input_buffering.is_stopped():
		player.fsm.change_state(player.jump_state)
	
	if player.velocity.y > 0:
		player.coyote_time.start()
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_pressed("crouch"):
		player.fsm.change_state(player.crouch_state)
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack and PlayerVariables.skill_1 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.get("attack_" + str(player.next_attack) + "_state"))
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack and PlayerVariables.skill_2 != "none":
		PlayerVariables.next_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.get("attack_" + str(player.next_attack) + "_state"))
	
	if Input.is_action_just_pressed("heal") and PlayerVariables.elemental_rupture != "":
		if PlayerVariables.elemental_rupture == PlayerVariables.get(PlayerVariables.skill_1 + "_element") or PlayerVariables.elemental_rupture == PlayerVariables.get(PlayerVariables.skill_2 + "_element"):
			player.fsm.change_state(player.heal_state)
