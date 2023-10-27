class_name PlayerFall
extends State

@export var player: CharacterBody2D
@export var animation: AnimationPlayer
@export var speed: float

signal fall_idle
signal fall_move
signal fall_double_jump

func _ready():
	set_physics_process(false)

func enter_state() -> void:
	set_physics_process(true)
	animation.play("jump")

func exit_state() -> void:
	set_physics_process(false)

func _physics_process(_delta):
	player.direction = Input.get_axis("left","right")
	player.velocity.x = player.direction * speed
	
	if player.is_on_floor():
		if player.direction == 0:
			fall_idle.emit()
		else:
			fall_move.emit()
	
	if Input.is_action_just_pressed("jump") and player.jump_count < player.max_jump_count:
		player.jump_count += 1
		fall_double_jump.emit()
