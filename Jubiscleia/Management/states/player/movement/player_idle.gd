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
	player.direction = Input.get_axis("left","right")
	
	if player.direction != 0 && player.is_on_floor():
		player.fsm.change_state(player.move_state)
	
	if Input.is_action_pressed("jump"):
		player.jump_count += 1
		player.fsm.change_state(player.jump_state)
	
	if player.velocity.y > 0:
		player.jump_count += 1
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_pressed("crouch"):
		player.fsm.change_state(player.crouch_state)
	
	if Input.is_action_just_pressed("attack_button_1"):
		player.fsm.change_state(player.skill_1_attack_1_state)
	
	if Input.is_action_just_pressed("attack_button_2"):
		player.fsm.change_state(player.skill_2_attack_1_state)
	
	if player.health_component.is_getting_hit:
		player.fsm.change_state(player.hit_state)
	
	if not player.alive:
		player.fsm.change_state(player.death_state)
