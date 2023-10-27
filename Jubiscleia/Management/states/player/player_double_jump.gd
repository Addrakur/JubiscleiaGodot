class_name PlayerDoubleJump
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

signal double_jump_fall

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
		double_jump_fall.emit()
