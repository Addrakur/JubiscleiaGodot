class_name PlayerMove
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

signal move_idle
signal move_jump
signal move_fall

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
		move_idle.emit()
	
	if Input.is_action_pressed("jump"):
		player.jump_count += 1
		move_jump.emit()
	
	if player.velocity.y > 0:
		player.jump_count += 1
		move_fall.emit()
