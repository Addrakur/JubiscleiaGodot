class_name PlayerCrouch
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

@onready var collision = $"../../Collision"

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	player.jump_count = 0
	collision.shape.size.y = 17
	collision.position.y = -8.5

func exit_state() -> void:
	set_physics_process(false)
	collision.shape.size.y = 28
	collision.position.y = -14
	

func _physics_process(_delta):
	animation.play("crouch")
	player.velocity.x = player.direction * speed
	
	if Input.is_action_pressed("jump") and Input.is_action_pressed("crouch"):
		player.position.y += 1
	
	if player.velocity.y > 0:
		player.jump_count += 1
		player.fsm.change_state(player.fall_state)
	
	if Input.is_action_just_released("crouch"):
		if player.direction == 0:
			player.fsm.change_state(player.idle_state)
		else:
			player.fsm.change_state(player.move_state)
