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
	
	if player.direction != 0 and player.is_on_floor():
		player.fsm.change_state(player.move_state)
	
	if Input.is_action_just_pressed("jump"):
		player.fsm.change_state(player.jump_state)
	
	if player.velocity.y > 0:
		player.coyote_time.start()
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_pressed("crouch"):
		player.fsm.change_state(player.crouch_state)
	
	if Input.is_action_just_pressed("attack_button_1") and PlayerVariables.can_attack:
		PlayerVariables.current_skill = PlayerVariables.skill_1
		player.fsm.change_state(player.get("attack_" + str(player.next_attack) + "_state"))
	
	if Input.is_action_just_pressed("attack_button_2") and PlayerVariables.can_attack:
		PlayerVariables.current_skill = PlayerVariables.skill_2
		player.fsm.change_state(player.get("attack_" + str(player.next_attack) + "_state"))
