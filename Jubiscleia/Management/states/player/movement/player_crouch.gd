class_name PlayerCrouch
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
	animation.play("down")
	player.velocity.x = player.direction * speed
	
	if Input.is_action_pressed("jump") and Input.is_action_pressed("look_down"):
		player.position.y += 1
	
	if player.velocity.y > 0:
		player.jump_count += 1
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_just_released("look_down"):
		if player.direction == 0:
			player.fsm.change_state(player.idle_state)
		else:
			player.fsm.change_state(player.move_state)
